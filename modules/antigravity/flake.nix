{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, antigravity-nix, ... }: {
    nixosModules.default =
        { pkgs, ... }:
        {
          environment.systemPackages = [
            antigravity-nix.packages.x86_64-linux.default
          ];
        };

      packages.x86_64-linux.default = antigravity-nix.packages.x86_64-linux.default;
    };
}