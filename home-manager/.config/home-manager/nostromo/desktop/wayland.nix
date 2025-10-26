{ config, lib, pkgs, ... }:

let
  # TODO: a bit dirty to have this here, but I only use it here
  fromJSONC = jsonc:
    builtins.fromJSON (
      builtins.readFile (
        pkgs.runCommand "from-jsonc"
          {
            FILE = pkgs.writeText "file.jsonc" jsonc;
            allowSubstitutes = false;
            preferLocalBuild = true;
          }
          ''
            # it's awkward, but it's works 😏
            ${pkgs.gcc}/bin/cpp -P -E "$FILE" > $out
            # or clang
          ''
      )
    );
in
{
  home.sessionVariables = {
    # fix issues with electron apps in wayland
    NIXOS_OZONE_WL = "1";
  };

  services.mako.enable = true;
  services.swayidle.enable = true;
  services.swaync.enable = true;

  programs = {
    waybar = {
      enable = true;
      systemd.enable = true;
      systemd.target = "niri.service";
      settings = {
        mainBar = fromJSONC (builtins.readFile ../../../../../waybar/.config/waybar/config.jsonrc);
      };
      style = ../../../../../waybar/.config/waybar/style.css;
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
