{ config, lib, pkgs, ... }:

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
}
