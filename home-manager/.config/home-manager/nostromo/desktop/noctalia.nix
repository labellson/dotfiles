{ config, lib, pkgs, dlsFuncs, inputs, ... }:

let
  noctaliaColorschemesPath = builtins.toString inputs.noctalia-colorschemes;
  linkFile = dlsFuncs.makeLinkFile config.lib.file.mkOutOfStoreSymlink;
  confFiles = lib.map linkFile [
    "niri/noctalia-shell.kdl"
    "noctalia/settings.json"
  ];
  confLinks = lib.mergeAttrsList confFiles;
in
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
  };

  xdg.configFile = {
    "noctalia/colorschemes/Solarized/Solarized.json".source = "${noctaliaColorschemesPath}/Solarized/Solarized.json";
  } // confLinks;
}
