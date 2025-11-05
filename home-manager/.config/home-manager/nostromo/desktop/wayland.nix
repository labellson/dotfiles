{ config, lib, pkgs, ... }:

{
  home.sessionVariables = {
    # fix issues with electron apps in wayland
    NIXOS_OZONE_WL = "1";
  };

  services.mako.enable = true;
  services.swayidle.enable = true;

  programs = {
    waybar = {
      enable = true;
      systemd.enable = true;
      systemd.target = "niri.service";
    };
    swaylock.enable = true;
    fuzzel.enable = true;
  };

  xdg.configFile = {
    "sway/config".source = ../../../../../sway/.config/sway/config;
    "niri/config.kdl".source = ../../../../../niri/.config/niri/config.kdl;
    "fuzzel/fuzzel.ini".source = ../../../../../fuzzel/.config/fuzzel/fuzzel.ini;
  };

  home.packages = with pkgs; [
    swaybg
    wdisplays
  ];

  systemd.user.services.swaybg = {
    Unit = {
      Description = "Wallpaper tool for wayland compositor";
      PartOf = "graphical-session.target";
      After = "graphical-session.target";
      Requisite = "graphical-session.target";
    };
    Service = {
      ExecStart = "${pkgs.swaybg}/bin/swaybg -m fill -i %h/.background-image";
      Restart = "on-failure";
    };
    Install = {
      # TODO: is there a way to do this better??
      WantedBy = [ "niri.service" ];
    };
  };
}
