{ config, lib, pkgs, ... }:

{
  programs.fish = {
    shellAbbrs = {
      hms = "home-manager switch --flake ~/.dotfiles#labellson@nostromo";
      edit = "$EDITOR";
      editn = "$EDITOR -n";
    };
  };
}
