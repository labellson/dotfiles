{ config, lib, pkgs, dlsFuncs, ... }:

let
  linkFile = dlsFuncs.makeLinkFile config.lib.file.mkOutOfStoreSymlink;
  confFiles = lib.map linkFile [
    "fcitx5/config"
    "fcitx5/profile"
    "fcitx5/conf/classicui.conf"
  ];
  confLinks = lib.mergeAttrsList confFiles;
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
