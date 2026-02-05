{ config, pkgs, pkgs-unstable, lib, symlinkRoot, ... }:

{
  imports = [
    ../modules/shell.nix
    ../modules/xdg.nix
    ../modules/gammastep.nix
    ../modules/tinty
    ../commons.nix
    ./fish.nix
    ../nostromo/desktop/wayland.nix
  ];

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # configure the username and all that things
  home.username = "labellson";
  home.homeDirectory = "/home/labellson";

  # keyboard keymap
  home.keyboard = {
    layout = "us,es";
    options = ["eurosign:e" "grp:shifts_toggle" "ctrl:nocaps"];
    variant = "intl,";
  };

  # allow fontconfig to discover fonts installed through home.packages
  fonts.fontconfig.enable = true;

  services.darkman.enable = true;
  services.darkman.package = pkgs-unstable.darkman;

  home.packages = with pkgs; [
    kitty
    ripgrep
    mosh
    btop

    niri

    firefox
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

    # needed by doom emacs
    fd
    gcc
    gnumake
    cmakeMinimal
    (aspellWithDicts (dicts: with dicts; [en es]))
    shellcheck
    nixfmt-rfc-style

    pandoc
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

  home.sessionVariables = {
    TERMINAL = "kitty";
  };

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
    configFile."systemd/user.conf".text = ''
        [Manager]
        ManagerEnvironment="XDG_DATA_DIRS=/nix/var/nix/profiles/default/share:/home/labellson/.nix-profile/share:/usr/share/ubuntu:/usr/local/share:/usr/share:/var/lib/snapd/desktop:/usr/local/share:/usr/share:/var/lib/snapd/desktop:/home/labellson/.nix-profile/share:/nix/var/nix/profiles/default/share:/home/labellson/.nix-profile/share:/nix/var/nix/profiles/default/share"
    '';
  };

  services.syncthing = {
    enable = true;
    tray.enable = true;
    settings.devices = {
      "Taiga S6 Lite" = {
        id = "PCTAJAA-AIH4CCZ-PDUPFE7-RMYU2AE-SSQTFLO-Q3IQZEW-H7OCH47-JVILIQH";
      };
      "Vostok Pi" = {
        id = "EYGINUF-ZXZC3G6-WMSUJPB-O7HTSQ6-BLLZ2MO-CWB5ZPQ-AZAPPBY-H3VWSQH";
      };
      "Sputnik Pi" = {
        id = "W76IR3H-VKVCXB4-GJ4ZZY3-OZ3EXGP-4NUCHW2-OZBIJ3Y-2VDEWOD-OX2ASAO";
      };
      "Tundra 13 mini" = {
        id = "472BSW5-7SUTFWA-ABZ6A2L-PQGVUME-UMMCIJX-WLSGQPA-DKAWSAT-DK7EAQU";
      };
    };
    settings.folders = {
      "my-notes" = {
        path = "/home/${config.home.username}/syncthing/my-notes";
        devices = [ "Taiga S6 Lite" "Vostok Pi" "Sputnik Pi" "Tundra 13 mini" ];
      };
    };
  };

  targets.genericLinux = {
    enable = true;
    # when sudo is available this solves issues to access GPU libraries without
    # having to use nixGL in non-NixOs systems.
    gpu.enable = true;
  };

  # Let Home Manager install and manage itself and enable git
  programs.home-manager.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05"; # Please read the comment before changing.
}
