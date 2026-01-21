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

  # Hide the OS choice for bootloaders.
  # It's still possible to open the bootloader list by pressing any key
  # It will just not appear on screen unless a key is pressed
  boot.loader.timeout = 0;

  # HW acceleration
  hardware.graphics.enable = true;

  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    # Java
    jdk21_headless
    jdk25_headless
    maven
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11";
}
