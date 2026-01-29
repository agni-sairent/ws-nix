{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    antigravity-module = {
      url = "path:./modules/antigravity";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      plasma-manager,
      antigravity-module,
      lanzaboote,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      overlay = final: prev: {
        opencode = final.callPackage ./pkgs/opencode { };
      };
      pkgs = import nixpkgs { inherit system; overlays = [ overlay ]; };
    in
    {
      # Overrides the original OpenCode package with local fork
      packages.${system}.opencode = pkgs.opencode;

      nixosConfigurations.hippaforalkus = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/hippaforalkus/default.nix
          ./common/default.nix
          inputs.antigravity-module.nixosModules.default
          home-manager.nixosModules.home-manager
#          lanzaboote.nixosModules.lanzaboote
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-backup";
            home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
            home-manager.users.agni = import ./hosts/hippaforalkus/home.nix;
          }
          ({ pkgs, lib, ... }: {
            nixpkgs.overlays = [ overlay ];
            environment.systemPackages = [
              pkgs.opencode
              pkgs.sbctl
            ];
            # Lanzaboote replaces the systemd-boot module.
#            boot.loader.systemd-boot.enable = lib.mkForce false;
#            boot.lanzaboote = {
#              enable = true;
#              pkiBundle = "/var/lib/sbctl";
#            };
          })
        ];
      };
      nixosConfigurations.destiny = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/destiny/default.nix
          ./common/default.nix
          inputs.antigravity-module.nixosModules.default
          home-manager.nixosModules.home-manager
          lanzaboote.nixosModules.lanzaboote
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-backup";
            home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
            home-manager.users.agni = import ./hosts/destiny/home.nix;
          }
          ({ pkgs, lib, ... }: {
            nixpkgs.overlays = [ overlay ];
            environment.systemPackages = [
              pkgs.opencode
              pkgs.sbctl
            ];
            # Lanzaboote replaces the systemd-boot module.
            boot.loader.systemd-boot.enable = lib.mkForce false;
            boot.lanzaboote = {
              enable = true;
              pkiBundle = "/var/lib/sbctl";
            };
          })
        ];
      };
    };
}
