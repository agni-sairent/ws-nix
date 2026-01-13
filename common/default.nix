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

  # Define a user account.
  users.users.agni = {
    isNormalUser = true;
    description = "Agni Sairent";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
    shell = pkgs.fish;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Programs
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
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.caskaydia-cove
    nerd-fonts.caskaydia-mono
  ];

  # Enable flakes permanently (no more --experimental-features flags needed)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
