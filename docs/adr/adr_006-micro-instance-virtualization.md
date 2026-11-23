# ADR 006: Cross-Platform Micro-Instance Virtualization (cx vm)

## Status

Accepted

## Context

ClauseOS requires an infrastructure and compute substrate capable of hosting Linux-kernel-exclusive workloads (such as bare-metal Kubernetes via k3s, systemd system daemons, container runtimes, and eBPF network tracing) across diverse host operating systems (Windows NT, Linux, macOS).

Running standard hypervisor solutions (e.g., VirtualBox, VMware, or unmanaged Docker Desktop) introduces severe virtualization overhead, degrades disk and memory I/O, pollutes global host storage, and complicates hardware GPU/NPU passthrough. Furthermore, third-party virtualization daemons create background services that mutate host network adapters and violate the zero-leak hermetic invariant of ClauseOS.

ClauseOS requires a disposable, featherweight micro-instance virtualization substrate that executes entirely unprivileged, stores all disk state strictly within `$env:CLAUSE_HOME`, spins up in under two seconds, and grants guest workloads transparent access to host silicon accelerators.

## Decision Drivers

- **Zero Host Mutation**: Virtual hard disks, kernel images, and instance state must reside strictly inside `$env:CLAUSE_HOME` (or `$env:LOCALAPPDATA\Programs\vms` on Windows, `$env:LIMA_HOME` on POSIX).
- **Sub-Second Spinup Velocity**: Micro-instances must initialize rapidly to serve as ephemeral test targets and runner workers.
- **Bare-Metal Silicon Passthrough**: Preserve direct access to host GPU and NPU hardware (NVIDIA CUDA, AMD ROCm, Apple Metal) from within Linux guest instances.
- **Unified Command Interface**: Expose cross-platform virtual machine operations through a single Nushell router verb: `cx vm {launch, exec, shell, list, stop, purge}`.

## Considered Options

1. **Container-in-Userland Engines (Rootless Podman / Docker)**: Enforces process isolation but cannot boot custom kernels or test native systemd service managers.
2. **Heavyweight Virtualization (Multipass / MicroCloud / VirtualBox)**: Evaluated in transcript d13 and early prototyping. Rejected due to background daemon installation on the host, Hyper-V interference with AMD ROCm/NPU compute, and multi-gigabyte memory footprints.
3. **Native Microkernel Bridge (WSL2 on Windows NT + Lima on macOS/Linux)**: Leverages lightweight, native OS virtualization bridges managed by hermetically confined scripts.

## Decision Outcome

Chosen Option: **Option 3 (WSL2 on Windows NT + Lima on macOS/Linux)**.

ClauseOS establishes the unified `cx vm` micro-instance virtualization engine, dynamically dispatching to the host-native microkernel bridge while confining all filesystem artifacts to `.home/`:

### 1. Windows NT Implementation (WSL2 Driver)

- **Engine**: Driven via `wsl.exe` targeting custom, unmanaged distribution instances initialized via `scripts/cli/pwsh/installers/installer_wsl.ps1`.
- **Filesystem Anchoring**: Micro-instance disk images are imported directly into:
  - `$env:CLAUSE_HOME\AppData\Local\Programs\vms\<instance_name>\ext4.vhdx`
- **Host Isolation Rules**:
  - The instance configuration (`/etc/wsl.conf`) explicitly disables Windows PATH appending (`[interop] appendWindowsPath = false`) to prevent host tool leakage into the guest.
  - Native systemd initialization is enabled (`[boot] systemd = true`) for running modern Linux service daemons.
- **Hardware Acceleration**: Transparent access to host DirectX / GPU compute via `/usr/lib/wsl/lib` and direct driver passthrough.

### 2. POSIX Implementation (Lima Driver on macOS and Linux)

- **Engine**: Driven via `limactl`, bootstrapped through `.mise.cloud.toml` (`"brew:lima" = "latest"`) and pinned inside `$env:HOMEBREW_PREFIX`.
- **Filesystem Anchoring**: All virtual machine templates, QCOW2 images, and runtime sockets are confined by setting:
  - `export LIMA_HOME="${CLAUSE_DATA_DIR}/vms"` (resolving to `${CLAUSE_HOME}/.local/share/vms`)
- **Container Target**: Lima templates provide ephemeral Alpine, Ubuntu, and Debian rootfs environments with pre-configured containerd and k3s runtimes.

### 3. CLI Command Surface (`cx vm`)

All micro-instance lifecycle operations are governed by `scripts/cli/nu/commands/vm.nu`:

- `cx vm launch <name> [--distro <alpine|ubuntu|debian>] [--memory <mb>]`: Spawns and configures a disposable instance.
- `cx vm exec <name> -- <command>`: Executes an ephemeral command within the micro-instance and streams stdout/stderr.
- `cx vm shell <name>`: Opens an interactive PTY session inside the instance.
- `cx vm list`: Enumerates active and stopped micro-instances with memory and disk metrics.
- `cx vm stop <name>`: Gracefully stops the micro-instance.
- `cx vm purge <name>`: Destroys the micro-instance and deletes its localized VHDX/QCOW2 disk image, recovering 100% of host storage.

## Consequences

### Positive

- True zero-leak virtualization: Deleting `$env:CLAUSE_HOME` removes all virtual machines, rootfs tarballs, and runtime disks without residual host hypervisor state.
- Enables air-gapped integration testing of Kubernetes manifests (`k3s`), Nomad Linux workers, and systemd services directly from developer workstations.
- Near-native I/O throughput and sub-second cold boot times on featherweight Alpine distributions.

### Negative

- Requires Windows NT 10.0+ with WSL2 platform components enabled and macOS/Linux with virtualization entitlements.
- Disk usage expands with the creation of multiple large Linux rootfs layers within `.home/`.
