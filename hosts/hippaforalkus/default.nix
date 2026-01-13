{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  networking.hostName = "hippaforalkus";

  # Host specific packages
  environment.systemPackages = with pkgs; [
    # The Rest
    affine
    discord
    element-desktop
    brave
    pear-desktop
    proton-pass
    proton-pass-cli
    protonvpn-gui
    yubioath-flutter
    # Work
    uv
    kubectl
    kubectl-cnpg
    kubectx
    postgresql_18
    jdk21_headless
    mattermost-desktop
    teams-for-linux
    thunderbird
    eduvpn-client
    # Ai
    antigravity
    codex
    # JetBrains
    jetbrains.pycharm
    jetbrains.idea
    jetbrains.goland
    jetbrains.rust-rover
  ];

  # DO NOT CHANGE: Tracks the NixOS version this host was first installed with.
  # This is used for backwards compatibility, not the current system version.
  system.stateVersion = "25.11";
}
