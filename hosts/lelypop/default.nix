{ config, pkgs, pkgsUnstable, lib, dlsFuncs, ... }:

let
  mkSymlink = dlsFuncs.mkSymlink config.lib.file.mkOutOfStoreSymlink;
  confLinks = lib.mergeAttrsList (
    lib.map mkSymlink [
      "niri/voxtype.kdl"
    ]
  );
in
{
  imports = [
    ./fish.nix

    ../../home-manager/modules/darkman.nix
    ../../home-manager/modules/gammastep.nix
    ../../home-manager/modules/tinty
    ../../home-manager/modules/llm.nix
    ../../home-manager/modules/i18n.nix
    ../../home-manager/modules/yazi.nix
    ../../home-manager/modules/syncthing.nix
    ../../home-manager/modules/tailscale.nix

    ../../home-manager/roles/desktop
  ];

  # keyboard keymap
  home.keyboard = {
    layout = "us,es";
    options = ["eurosign:e" "grp:shifts_toggle" "ctrl:nocaps"];
    variant = "intl,";
  };

  # allow fontconfig to discover fonts installed through home.packages
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    ripgrep
    mosh
    btop

    usql
    pgcli

    niri

    firefox
    pywalfox-native
    vlc
    overskride
    noisetorch
    pavucontrol
    dconf
    evince

    xfce.thunar

    spotify
    playerctl

    databricks-cli
    azure-cli

    neovim
    emacs-pgtk
    nil
    nodejs # just to install lsp-servers
    jq
    usql
    go-grip # grip markdown preview

    # needed by doom emacs
    fd
    gcc
    gnumake
    cmakeMinimal
    (aspellWithDicts (dicts: with dicts; [en es]))
    shellcheck
    nixfmt
    libtool  # needed to compile vterm

    pandoc
    texliveFull
    xan

    # i like to have it installed
    (python313.withPackages(ps: with ps; [requests ipython]))
    pre-commit
    uv

    # fonts
    fantasque-sans-mono
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.gohufont
    nerd-fonts.symbols-only
  ];

  # I'm not able to make swaylock working with Ubuntu PAM so I will use the
  # provided one in Ubuntu repositories
  programs.swaylock.enable = lib.mkForce false;

  gtk = {
    enable = true;
    theme = {
        package = pkgs.adw-gtk3;
        name = "adw-gtk3";
    };
  };
  xdg = {
    enable = true;
    mime.enable = true;
    # fix screensharing: https://cashmere.rs/blog/20250612002456-how-to-fix-screensharing-for-niri-wm-under-nixos/
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
      config = {
        common = {
          default = [ "gtk" ];
        };
        niri = {
        default = [
            "gtk"
            "gnome"
        ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
        };
      };
    };
    # fix systemd reads portal systems: https://discourse.nixos.org/t/configuring-xdg-desktop-portal-with-home-manager-on-ubuntu-hyprland-via-nixgl/65287/6
    configFile = {
      "systemd/user.conf".text = ''
          [Manager]
          ManagerEnvironment="XDG_DATA_DIRS=/nix/var/nix/profiles/default/share:/home/labellson/.nix-profile/share:/usr/share/ubuntu:/usr/local/share:/usr/share:/var/lib/snapd/desktop:/usr/local/share:/usr/share:/var/lib/snapd/desktop:/home/labellson/.nix-profile/share:/nix/var/nix/profiles/default/share:/home/labellson/.nix-profile/share:/nix/var/nix/profiles/default/share"
      '';
    } // confLinks;
  };

  targets.genericLinux = {
    enable = true;
    # when sudo is available this solves issues to access GPU libraries without
    # having to use nixGL in non-NixOs systems.
    gpu.enable = true;
  };
}
