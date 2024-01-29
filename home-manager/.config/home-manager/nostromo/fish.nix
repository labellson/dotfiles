{ config, lib, pkgs, ... }:

{
  programs.fish = {
    shellAbbrs = {
      hms = "home-manager switch --flake ~/.dotfiles#labellson@nostromo";
      edit = "emacsclient -a '' -r -n";
    };
  };
}
