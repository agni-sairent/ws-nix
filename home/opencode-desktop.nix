{
  inputs.opencode-desktop.url = "github:tomsch/opencode-desktop-nix";

  outputs =
    {
      self,
      nixpkgs,
      opencode-desktop,
      ...
    }:
    {
      # NixOS
      nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
        modules = [
          {
            environment.systemPackages = [
              opencode-desktop.packages.x86_64-linux.default
            ];
          }
        ];
      };
    };
}
