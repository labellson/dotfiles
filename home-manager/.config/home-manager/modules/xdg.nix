{ config, lib, pkgs, symlinkRoot, ... }:

let
  # import some useful functions
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (lib) map mergeAttrsList;

  # make helper functions to link files
  toSrcFile = name: "${symlinkRoot}/${name}";
  link = name: mkOutOfStoreSymlink (toSrcFile name);

  # use previous functions to create helper functions to create attrSets
  linkFile = name: {
    ${name}.source = link name;
  };
  linkDir = name: {
    ${name} = {
      source = link name;
      recursive = true;
    };
  };

  # declare the config files to link
  confFiles = map linkFile [
    "tinted-theming/tinty/config.toml"
  ] ++ [
    { "darkman/config.yaml".source = link "darkman/.config/darkman/config.yaml"; }
  ];

  confLinks = mergeAttrsList confFiles;
in
{
  # to $XDG_CONFIG_DIR
  xdg.configFile = confLinks;

  # to $XDG_DATA_DIR
  xdg.dataFile = {
    "darkman" = {
      source = link "darkman/.local/share/darkman";
      recursive = true;
    };
    "dark-mode.d" = {
      source = link "darkman/.local/share/dark-mode.d";
      recursive = true;
    };
    "light-mode.d" = {
      source = link "darkman/.local/share/light-mode.d";
      recursive = true;
    };
  };
}
