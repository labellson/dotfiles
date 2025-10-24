{ config, lib, pkgs, ... }:

{
  services.mako.enable = true;
  services.swayidle.enable = true;

  programs = {
    waybar.enable = true;
    swaylock.enable = true;
    fuzzel.enable = true;
  };

  xdg.configFile = {
    "sway/config".source = ../../../../../sway/.config/sway/config;
    "niri/config.kdl".source = ../../../../../niri/.config/niri/config.kdl;
    "fuzzel/fuzzel.ini".source = ../../../../../fuzzel/.config/fuzzel/fuzzel.ini;
  };
}
