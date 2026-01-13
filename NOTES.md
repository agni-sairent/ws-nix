# NixOS Flake Cheatsheet

Here are the essential commands for managing your new Flake-based system.

## Rebuilding
Apply changes to your system:
```bash
sudo nixos-rebuild switch --flake .
```
*Note: The `.` refers to the current directory containing `flake.nix`.*

## Updating
Update all inputs (e.g., update `nixos-unstable` to latest):
```bash
nix flake update
sudo nixos-rebuild switch --flake .
```

## Maintenance
Garbage collect old generations (saves space):
```bash
nix-collect-garbage -d
sudo nix-collect-garbage -d
```
Optimize store (deduplicate files):
```bash
nix-store --optimise
```

## Debugging
Check flake syntax/validity:
```bash
nix flake check
```
Show what the flake provides:
```bash
nix flake show
```
Build without switching (good for testing):
```bash
nixos-rebuild dry-build --flake .
```
