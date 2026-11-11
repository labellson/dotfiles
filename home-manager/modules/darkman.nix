{ config, lib, pkgs, dlsFuncs, ... }:

let
  makeLink = dlsFuncs.makeLink config.lib.file.mkOutOfStoreSymlink;
in
{
  services.darkman.enable = true;

  home.packages = with pkgs; [
    # one of the scripts uses dconf
    dconf
  ];

  xdg.configFile."darkman/config.yaml".source = makeLink "darkman/config/darkman/config.yaml";
  xdg.dataFile = {
    "darkman" = {
      source = makeLink "darkman/local/share/darkman";
      recursive = true;
    };
    "dark-mode.d" = {
      source = makeLink "darkman/local/share/dark-mode.d";
      recursive = true;
    };
    "light-mode.d" = {
      source = makeLink "darkman/local/share/light-mode.d";
      recursive = true;
    };
  };

  # darkman home manager unit BindsTo=graphical-session.target. Apparently this
  # triggers the unit to run before WAYLAND_DISPLAY or NIRI_SOCKET is set.
  # Therefore it makes it fail
  systemd.user.services.darkman.Unit.BindsTo = lib.mkForce [ ];
}
