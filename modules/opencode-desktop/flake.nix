{
  description = "OpenCode Desktop Module";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    opencode-desktop.url = "github:tomsch/opencode-desktop-nix";
    opencode-desktop.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      opencode-desktop,
      ...
    }:
    {
      nixosModules.default =
        { pkgs, ... }:
        {
          environment.systemPackages = [
            opencode-desktop.packages.x86_64-linux.default
          ];
        };

      packages.x86_64-linux.default = opencode-desktop.packages.x86_64-linux.default;
    };
}
