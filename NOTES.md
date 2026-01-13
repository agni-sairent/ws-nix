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

---

## Home Manager

Home Manager manages **user-level** configuration (dotfiles, user packages, user services) declaratively, the same way NixOS manages system config.

### Structure
```
home/common.nix           → Shared user config (Fish, Starship, Git)
hosts/<hostname>/home.nix → Host-specific overrides (imports common.nix)
```

### Key Concepts
- `programs.<name>.enable = true` — Enables and configures a program
- `home.packages` — User-specific packages (alternative to system packages)
- `home.file` — Manage arbitrary dotfiles
- `home.stateVersion` — Same concept as `system.stateVersion`, don't change it

### Useful Options Examples
```nix
# Shell abbreviations
programs.fish.shellAbbrs = { k = "kubectl"; };

# Git config
programs.git.settings.user.email = "you@example.com";

# Starship prompt
programs.starship.enable = true;
```

### Finding Options
Search available Home Manager options:
```bash
man home-configuration.nix
```
Or browse: https://nix-community.github.io/home-manager/options.xhtml

