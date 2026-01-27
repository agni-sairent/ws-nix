{ config, pkgs, ... }:

{
  # Timezone and Locales
  time.timeZone = "Europe/Prague";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocales = [ "cs_CZ.UTF-8/UTF-8" ];

  i18n.extraLocaleSettings = {
    LC_CTYPE = "en_US.UTF-8";
    LC_COLLATE = "en_US.UTF-8";
    LC_ADDRESS = "cs_CZ.UTF-8";
    LC_IDENTIFICATION = "cs_CZ.UTF-8";
    LC_MEASUREMENT = "cs_CZ.UTF-8";
    LC_MONETARY = "cs_CZ.UTF-8";
    LC_NAME = "cs_CZ.UTF-8";
    LC_NUMERIC = "cs_CZ.UTF-8";
    LC_PAPER = "cs_CZ.UTF-8";
    LC_TELEPHONE = "cs_CZ.UTF-8";
    LC_TIME = "cs_CZ.UTF-8";
    LC_MESSAGES = "cs_CZ.UTF-8";
  };

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.consoleMode = "max";

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Plymouth
  # https://wiki.nixos.org/wiki/Plymouth
  boot = {
    plymouth = {
      enable = true;
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
  };

  # Fixes Luks password prompt dropping out of Plymouth; default
  boot.initrd.systemd.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Auto delete generations older than 30 days
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

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
  ];

  # Auto unlock wallet on login via PAM module (should help apps gain access to it)
  security.pam.services.login.kwallet.enable = true;

  # Enable U2F auth for login and sudo (YubiKey) - setup: https://wiki.nixos.org/wiki/Yubikey
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };
  security.pam.u2f.settings.cue = true;

  # Main user
  users.users.agni = {
    isNormalUser = true;
    description = "Agni Sairent";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [
      kdePackages.kate
    ];
    shell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;
  programs.ssh = {
    startAgent = true;
    enableAskPassword = true;
  };

  # Global env vars
  environment.variables = {
    SSH_ASKPASS_REQUIRE = "prefer";
    KUBECONFIG = "$HOME/.config/kubeconfigs/kubeconfig.yaml";
  };

  # Docker
  virtualisation.docker.enable = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    # System
    pam_u2f
    wireguard-tools
    kdePackages.partitionmanager
    # Core
    git
    ghostty
    micro-full
    python314
    btop-rocm
    gparted-full
    nixfmt
    direnv
    # KDE
    kdePackages.kcalc
    # kdePackages.neochat wtf is wrong with this
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
    codex
    jetbrains.pycharm
    jetbrains.idea
    jetbrains.goland
    jetbrains.rust-rover
    insomnia
    # Home Ops
    fluxcd
    kubectl
    kubectl-cnpg
    kubectx
    postgresql_18
    # The Rest
    solaar
    affine
    discord
    element-desktop
    brave
    pear-desktop
    proton-pass
    proton-pass-cli
    protonvpn-gui
    yubioath-flutter
    fluffychat
    # Work shared
    mattermost-desktop
    teams-for-linux
    thunderbird
    eduvpn-client
    docker-buildx
    docker-compose
  ];

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.caskaydia-cove
    nerd-fonts.caskaydia-mono
  ];

  # Enable flakes permanently (no more --experimental-features flags needed)
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
