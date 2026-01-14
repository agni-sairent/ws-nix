{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  networking.hostName = "hippaforalkus";

  # Host specific packages
  environment.systemPackages = with pkgs; [
    # Work
    jdk21_headless
    mattermost-desktop
    teams-for-linux
    thunderbird
    eduvpn-client
  ];

  # DO NOT CHANGE: Tracks the NixOS version this host was first installed with.
  # This is used for backwards compatibility, not the current system version.
  system.stateVersion = "25.11";
}
