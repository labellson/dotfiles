{ config, lib, pkgs, pkgsUnstable, dlsFuncs, inputs, ... }:

let
  inherit (inputs) voxtype;

  mkSymlink = dlsFuncs.mkSymlink config.lib.file.mkOutOfStoreSymlink;
  confLinks = lib.mergeAttrsList (
    lib.map mkSymlink [
      "niri/voxtype.kdl"
    ]
  );
in
{
  imports = [ voxtype.homeManagerModules.default ];


  # HACK: needed because the service can't find the plugins library
  home.packages = with pkgs; [ alsa-plugins ];
  home.sessionVariables = {
    ALSA_PLUGIN_DIR = "${pkgs.alsa-plugins}/lib/alsa-lib";
  };

  programs.voxtype = {
    enable = true;
    package = pkgsUnstable.voxtype-onnx;
    engine = "parakeet";
    model.path = "/home/${config.home.username}/.local/share/voxtype/models/parakeet-tdt-0.6b-v3-int8";
    service.enable = false;
    settings = {
      hotkey.enabled = false;
      whisper.language = "en";
      audio.feedback ={
        enabled = true;
        theme = "default";
      };
    };
  };

  xdg.configFile = confLinks;
}
