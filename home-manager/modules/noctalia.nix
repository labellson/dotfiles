{ config, lib, pkgs, dlsFuncs, inputs, ... }:

let
  mkSymlink = dlsFuncs.mkSymlink config.lib.file.mkOutOfStoreSymlink;
  confLinks = lib.mergeAttrsList (
    lib.map mkSymlink [
      "niri/noctalia-shell.kdl"
      "noctalia/noctalia-config.toml"
      # TODO: this two are for noctalia v4. should be deleted at some point
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

  home.packages = with pkgs; [
    # packages needed by screen-toolkit plugin
    slurp grim hyprpicker imagemagick zbar curl jq ffmpeg bc
    wl-screenrec translate-shell satty
    (tesseract.override { enableLanguages = [ "eng" "spa" ]; })

    # packages needed by audio-switcher plugin
    pulseaudio bluez
  ];

  xdg.configFile = confLinks;
}
