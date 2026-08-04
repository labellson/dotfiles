{ config, lib, pkgs, ... }:

{
  programs.fish = {
    shellAbbrs = {
      hms = "home-manager switch --flake ~/.dotfiles#labellson@xiaoyue";
      edit = "emacsclient -a '' -r -n";
    };
  };
}
