{ config, pkgs, ... }:

{
  # Set your time zone.
  time.timeZone = "Europe/Prague";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "cs_CZ.UTF-8";
    LC_IDENTIFICATION = "cs_CZ.UTF-8";
    LC_MEASUREMENT = "cs_CZ.UTF-8";
    LC_MONETARY = "cs_CZ.UTF-8";
    LC_NAME = "cs_CZ.UTF-8";
    LC_NUMERIC = "cs_CZ.UTF-8";
    LC_PAPER = "cs_CZ.UTF-8";
    LC_TELEPHONE = "cs_CZ.UTF-8";
    LC_TIME = "cs_CZ.UTF-8";
  };

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable sound with pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # KDE Plasma
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  # Blacklist unwanted plasma packages
  environment.plasma6.excludePackages = with pkgs; [
    kdePackages.kmahjongg
    kdePackages.kmines
    kdePackages.konversation
    mpv
  ];

  # Auto unlock wallet on login via PAM module (should help apps gain access to it)
  security.pam.services.login.kwallet.enable = true;

  users.users.agni = {
    isNormalUser = true;
    description = "Agni Sairent";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
    shell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;
  programs.firefox.enable = true;
  programs.ssh = {
    startAgent = true;
    enableAskPassword = true;
  };

  # Global env vars
  environment.variables = {
    SSH_ASKPASS_REQUIRE = "prefer";	
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    # System
    pam_u2f
    wireguard-tools
    # Core
    git
    ghostty
    micro-full
    python314
    btop-rocm
    # Fish
    starship
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fzf
    fishPlugins.grc
    grc
    # Home Dev
    uv
    antigravity
    codex
    jetbrains.pycharm
    jetbrains.idea
    jetbrains.goland
    jetbrains.rust-rover
    # Home Ops
    fluxcd
    kubectl
    kubectl-cnpg
    kubectx
    postgresql_18
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
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.caskaydia-cove
    nerd-fonts.caskaydia-mono
  ];

  # Enable flakes permanently (no more --experimental-features flags needed)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
