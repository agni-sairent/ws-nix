{
  config,
  pkgs,
  opencode-desktop,
  ...
}:

{
  environment.systemPackages = [
    # OpenCode
    opencode-desktop.packages.x86_64-linux.default
  ];
}
