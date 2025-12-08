{ config, lib, pkgs, ... }:

{
  programs.fish = {
    shellAbbrs = {
      hms = "home-manager switch --flake ~/.dotfiles#labellson@lelypop";
      doom = "~/.config/emacs/bin/doom";
    };
  };
}
