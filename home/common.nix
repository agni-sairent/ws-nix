{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      k = "kubectl";
      kctx = "kubectx";
      kns = "kubens";
    };
  };

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "Dušan Tichý";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };

  programs.plasma = {
    enable = true;
    shortcuts = {
      ActivityManager.switch-to-activity-8a2192d1-b4bb-412c-8906-37fc2733703b = [ ];
      "KDE Keyboard Layout Switcher"."Switch to Next Keyboard Layout" = "Meta+Space";
    };
    configFile = {
      kcminputrc."Libinput/5426/195/Razer Razer DeathAdder V3 Pro".PointerAccelerationProfile = 1;
      kcminputrc."Libinput/5426/195/Razer Razer DeathAdder V3 Pro Mouse".PointerAccelerationProfile = 1;
      kdeglobals.General.BrowserApplication = "brave-browser.desktop";
      kdeglobals.General.TerminalApplication = "/nix/store/4fkwvnja07zmivbi0l68351rzd3166hp-ghostty-1.2.3/bin/ghostty --gtk-single-instance=true";
      kdeglobals.General.TerminalService = "com.mitchellh.ghostty.desktop";
      ksmserverrc.General.loginMode = "emptySession";
      kwalletrc.Wallet."First Use" = false;
      plasmanotifyrc."Applications/brave-browser".Seen = true;
      plasmanotifyrc.Notifications.LowPriorityHistory = true;
    };
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Honeywave/contents/images/5120x2880.png";
    };
  };

  # Dotfiles
  xdg.configFile."discord/settings.json".source = ./files/discord-settings.json;
  xdg.configFile."ghostty/config".source = ./files/ghostty-config;

  # This file contains a reference to wherever the system ssh-agent create's its socket.
  home.file = {
    ".config/environment.d/ssh-agent.conf" = {
      source = ./files/ssh-agent;
    };
    ".config/agents" = {
      source = "./files/agents";
      recursive = true;
    };
  };

  # DO NOT CHANGE: Tracks the Home Manager version this user config was first created with.
  home.stateVersion = "25.11";
}
