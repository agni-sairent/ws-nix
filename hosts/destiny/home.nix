{ config, pkgs, ... }:

{
  imports = [ ../../home/common.nix ];

  programs.git.settings.user.email = "tichy.dusan@proton.me";
}
