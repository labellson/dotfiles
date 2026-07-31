{ config, lib, pkgs, dlsFuncs, inputs, ... }:

let
  mkSymlink = dlsFuncs.mkSymlink config.lib.file.mkOutOfStoreSymlink;
  confLinks = lib.mergeAttrsList (
    lib.map mkSymlink [
      "niri/noctalia-shell.kdl"
      "noctalia/noctalia-config.toml"
      # todo: this two are for noctalia v4. should be deleted at some point
      "noctalia/settings.json"
      "noctalia/plugins.json"
    ]
  );
in
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;
  };

  # fix missing icons in the shell
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "gtk3";
  };

  # TODO: packages needed by screen-toolkit plugin. plugin is for v4
  home.packages = with pkgs; [
    grim slurp wl-clipboard imagemagick zbar curl
    translate-shell wl-screenrec ffmpeg gifski
    (tesseract.override { enableLanguages = [ "eng" "spa" ]; })

    # packages needed by audio-switcher plugin
    pulseaudio bluez
  ];

  xdg.configFile = confLinks;
}
