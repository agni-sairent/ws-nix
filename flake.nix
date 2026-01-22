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
    opencode-desktop.url = "github:tomsch/opencode-desktop-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      plasma-manager,
      opencode-desktop,
      ...
    }@inputs:
    {
      nixosConfigurations.hippaforalkus = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/hippaforalkus/default.nix
          ./common/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-backup";
            home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
            home-manager.users.agni = import ./hosts/hippaforalkus/home.nix;
          }
        ];
      };
      nixosConfigurations.destiny = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/destiny/default.nix
          ./common/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-backup";
            home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
            home-manager.users.agni = import ./hosts/destiny/home.nix;
          }
        ];
      };
    };
}
