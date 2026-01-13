{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "hippaforalkus";
  
  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = false;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

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
