{ config, lib, pkgs, dlsFuncs, inputs, ... }:

# TODO: how could I pass this helper functions to other modules??
let
  linkFile = dlsFuncs.makeLinkFile config.lib.file.mkOutOfStoreSymlink;
  confFiles = lib.map linkFile [
    "kanshi/config"
    "fuzzel/fuzzel.ini"
  ];
  confLinks = lib.mergeAttrsList confFiles;
in
{
  home.sessionVariables = {
    # fix issues with electron apps in wayland
    NIXOS_OZONE_WL = "1";
  };

  # services.mako.enable = true;
  services.kanshi.enable = true;

  programs = {
    fuzzel.enable = true;
    imv.enable = true;
  };

  xdg.configFile = confLinks;

  home.packages = with pkgs; [
    # swaybg
    wdisplays
    xwayland-satellite
    # although is called this way, it provides pulseaudio-control to control
    # pulseaudio from any statusbar
    polybar-pulseaudio-control
    ianny
  ];
}
