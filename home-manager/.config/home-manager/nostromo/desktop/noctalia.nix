{ config, lib, pkgs, dlsFuncs, inputs, ... }:

let
  noctaliaColorschemesPath = builtins.toString inputs.noctalia-colorschemes;
  linkFile = dlsFuncs.makeLinkFile config.lib.file.mkOutOfStoreSymlink;
  confFiles = lib.map linkFile [
    "niri/noctalia-shell.kdl"
    "noctalia/settings.json"
    "noctalia/plugins.json"
  ];
  confLinks = lib.mergeAttrsList confFiles;
in
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override { calendarSupport = true; };
  };

  # fix missing icons in the shell
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "gtk3";
  };

  # packages needed by screen-toolkit plugin
  home.packages = with pkgs; [
    grim slurp wl-clipboard imagemagick zbar curl
    translate-shell wl-screenrec ffmpeg gifski
    (tesseract.override { enableLanguages = [ "eng" "spa" ]; })
  ];

  xdg.configFile = {
    "noctalia/colorschemes/Solarized/Solarized.json".source = "${noctaliaColorschemesPath}/Solarized/Solarized.json";
  } // confLinks;
}
