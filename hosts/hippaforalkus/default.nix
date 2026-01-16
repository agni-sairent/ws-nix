{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "hippaforalkus";

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024;
    }
  ];

  # Host specific packages
  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    # Java
    jdk21_headless
    jdk25_headless
    maven
  ];

  # DO NOT CHANGE: Tracks the NixOS version this host was first installed with.
  # This is used for backwards compatibility, not the current system version.
  system.stateVersion = "25.11";
}
