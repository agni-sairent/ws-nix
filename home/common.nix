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

  # Dotfiles
  xdg.configFile."discord/settings.json".source = ./files/discord-settings.json;

  # DO NOT CHANGE: Tracks the Home Manager version this user config was first created with.
  home.stateVersion = "25.11";
}
