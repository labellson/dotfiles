{ config, lib, pkgs, dls, ... }:

let
  # import some useful functions
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (lib) map mergeAttrsList;

  link = name: mkOutOfStoreSymlink (dls.toSrcFile name);

  # use previous functions to create helper functions to create attrSets
  linkDir = name: {
    ${name} = {
      source = link name;
      recursive = true;
    };
  };

  # declare the config dirs to link
  confDirs = map linkDir [
    "fcitx5"
  ];

  confLinks = mergeAttrsList confDirs;
in
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-gtk
        fcitx5-bamboo  # Vietnamese input
        kdePackages.fcitx5-chinese-addons  # pinyin input

        # themes
        fcitx5-mellow-themes
      ];
    };
  };
  xdg.configFile = confLinks;
}
