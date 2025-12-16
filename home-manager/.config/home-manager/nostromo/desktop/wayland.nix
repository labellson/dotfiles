{ config, lib, pkgs, symlinkRoot, inputs, ... }:

# TODO: how could I pass this helper functions to other modules??
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
    "waybar/config.jsonc"
    "waybar/style.css"
    "mako/config"
    "kanshi/config"
    "sway/config"
    "niri/config.kdl"
    "fuzzel/fuzzel.ini"
    "stasis/stasis.rune"
  ];

  # declare dirs to link
  confDirs = map linkDir [
    "waybar/scripts"
  ];

  confLinks = mergeAttrsList (confFiles ++ confDirs);
in
{
  home.sessionVariables = {
    # fix issues with electron apps in wayland
    NIXOS_OZONE_WL = "1";
  };

  services.mako.enable = true;
  services.swayidle.enable = true;
  services.kanshi.enable = true;

  programs = {
    waybar = {
      enable = true;
      systemd.enable = true;
      systemd.target = "niri.service";
    };
    swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
    };
    fuzzel.enable = true;
    imv.enable = true;
  };

  xdg.configFile = confLinks;

  home.packages = with pkgs; [
    swaybg
    wdisplays
    inputs.nfsm-flake.packages.${stdenv.hostPlatform.system}.nfsm
    inputs.nfsm-flake.packages.${stdenv.hostPlatform.system}.nfsm-cli
    pkgs.stasis
    xwayland-satellite
    # although is called this way, it provides pulseaudio-control to control
    # pulseaudio from any statusbar
    polybar-pulseaudio-control
  ];

  systemd.user.services = let
      graphical-target = "graphical-session.target";
    in {
      swaybg = {
        Unit = {
          Description = "Wallpaper tool for wayland compositor";
          PartOf = graphical-target;
          After = graphical-target;
          Requisite = graphical-target;
        };
        Service = {
          ExecStart = "${pkgs.swaybg}/bin/swaybg -m fill -i %h/.background-image";
          Restart = "on-failure";
        };
        Install = {
          # TODO: is there a way to do this better??
          WantedBy = [ "niri.service" ];
        };
      };

    #   stasis = {
    #     Unit = {
    #       Description = "Stasis wayland idle manager";
    #       After = graphical-target;
    #       Wants = graphical-target;
    #     };
    #     Service = {
    #       Type = "simple";
    #       ExecStart = "${pkgs.stasis}/bin/stasis";
    #       Restart = "always";
    #       RestartSec = 5;
    #     };
    #     Install = {
    #        WantedBy = [ "niri.service" ];
    #     };
    # };
  };
}
