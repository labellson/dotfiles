{ config, lib, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
  };

  home.file = {
    # sway
    ".config/sway/config".source = ../../../../../sway/.config/sway/config;
  };
}
