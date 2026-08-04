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

  # declare the config files to link
  confFiles = map linkFile [
    "tinted-theming/tinty/config.toml"
    "kitty/kitty.conf"
  ];

  confLinks = mergeAttrsList confFiles;
in
{
  # to $XDG_CONFIG_DIR
  xdg.configFile = confLinks;
}
