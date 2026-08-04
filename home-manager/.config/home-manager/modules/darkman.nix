{ config, lib, pkgs, dlsFuncs, ... }:

let
  makeLink = dlsFuncs.makeLink config.lib.file.mkOutOfStoreSymlink;
in
{
  services.darkman.enable = true;

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
}
