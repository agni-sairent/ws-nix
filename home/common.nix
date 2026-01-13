{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      k = "kubectl";
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

  # DO NOT CHANGE: Tracks the Home Manager version this user config was first created with.
  home.stateVersion = "25.11";
}
