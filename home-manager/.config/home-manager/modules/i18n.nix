{ config, lib, pkgs, dlsFuncs, ... }:

let
  mkSymlink = dlsFuncs.mkSymlink config.lib.file.mkOutOfStoreSymlink;
  confLinks = lib.mergeAttrsList (
    lib.map mkSymlink [
      "fcitx5/config"
      "fcitx5/profile"
      "fcitx5/conf/classicui.conf"
    ]
  );
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
