{ config, pkgs, ... }:

{
  imports = [ ../../home/common.nix ];

  # Host-specific Home Manager configuration
  # Override or extend common settings here

  # Work git email
  programs.git.settings.user.email = "tichy@ics.muni.cz";
}
