{ config, pkgs, inputs, ... }:

let
  # so happy to make my 1st derivation
  polybar-pulseaudio-control = pkgs.callPackage ../derivations/polybar-pulseaudio-control.nix {};
  adw-colors = pkgs.callPackage ../derivations/adw-colors.nix {};
in
{
  imports = [
    ../modules/shell.nix
    ./fish.nix
  ];

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "labellson";
  home.homeDirectory = "/home/labellson";

  # Config keyboard keymap
  home.keyboard = {
    layout = "us,es";
    options = ["eurosign:e" "grp:shifts_toggle" "ctrl:nocaps"];
    variant = "intl,";
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # let home manager start the X session
  xsession.enable = true;

  programs.autorandr = {
    enable = true;
    hooks.postswitch = {
      "reset-background.sh" = ''
      #!/usr/bin/env sh
      feh --no-fehbg --bg-fill ~/.background-image
      '';
    };
    profiles = {
      "home"= {
        fingerprint = {
          DP1 = "00ffffffffffff0010acc2d054584630111d010380351e78eaad75a9544d9d260f5054a54b008100b300d100714fa9408180d1c00101565e00a0a0a02950302035000e282100001a000000ff004d59334e44393450304658540a000000fc0044454c4c205032343138440a20000000fd0031561d711c000a202020202020010202031bb15090050403020716010611121513141f2065030c001000023a801871382d40582c45000e282100001e011d8018711c1620582c25000e282100009ebf1600a08038134030203a000e282100001a7e3900a080381f4030203a000e282100001a00000000000000000000000000000000000000000000000000000000d8";
          eDP1 = "00ffffffffffff004d1053140000000028190104a52313780ede50a3544c99260f5054000000010101010101010101010101010101011a3680a070381f40302035005ac210000018000000000000000000000000000000000000000000fe00313230334d814c513135364d31000000000002410328001200000a010a2020004a";
        };
        config = {
          HDMI1.enable = false;
          HDMI2.enable = false;
          VIRTUAL1.enable = false;
          eDP1.enable = false;
          DP2.enable = false;
          DP1 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            gamma = "0.769:0.588:0.435";
            mode = "2560x1440";
            rate = "60.00";
          };
        };
      };
    };
  };

  # gnupg
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableFishIntegration = true;
    pinentry.package = pkgs.pinentry-rofi;
  };

  # allow fontconfig to discover fonts installed through home.packages
  fonts.fontconfig.enable = true;

  # gaming
  programs.mangohud.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    kitty
    ripgrep
    killall
    mosh

    (polybar.override {i3Support = true;})
    polybar-pulseaudio-control
    rofi
    rofi-bluetooth
    bc # needed by rofi-bluetooth

    pavucontrol

    firefox
    google-chrome
    obsidian  # says that electron 24 is an insecure package
    telegram-desktop
    nextcloud-client
    vlc
    darkman
    arandr
    ncdu
    transmission_4-gtk
    calibre
    libreoffice

    emacs
    neovim
    nil  # nix language server
    nodejs # just to install lsp-servers

    # needed by doom emacs
    fd
    libtool
    gcc
    gnumake
    cmakeMinimal
    (aspellWithDicts (dicts: with dicts; [en es]))
    shellcheck
    nixfmt-rfc-style

    # i like to have it installed
    (python311.withPackages(ps: with ps; [requests ipython]))
    uv

    stremio

    # polish
    lxappearance
    adw-colors
    feh

    # system comes from pkgs.system
    # inputs.paisa.packages.${system}.default
    ledger
    hledger
    tradingview

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    #

    # fonts
    fantasque-sans-mono
  ];

  services.gammastep = {
    enable = true;
    latitude = 51.9;
    longitude = 4.5;
    provider = "manual";
    temperature.day = 5700;
    temperature.night = 3500;
    settings = {
      general = {
        gamma = 0.8;
      };
    };
  };

  gtk = {
    enable = true;
    theme.package = pkgs.adw-gtk3;
    theme.name = "adw-gtk3";
    cursorTheme.package = pkgs.vanilla-dmz;
    cursorTheme.name = "Vanilla-DMZ-AA";
    iconTheme.package = (pkgs.papirus-icon-theme.override {color = "deeporange";});
    iconTheme.name = "Papirus";
    gtk2.extraConfig = ''
      gtk-button-images=1
      gtk-menu-images=1
      gtk-enable-event-sounds=1
      gtk-enable-input-feedback-sounds=1
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-hintstyle="hitslight"
    '';
    gtk3.extraConfig = {
      gtk-button-images=1;
      gtk-menu-images=1;
      gtk-enable-event-sounds=1;
      gtk-enable-input-feedback-sounds=1;
      gtk-xft-antialias=1;
      gtk-xft-hinting=1;
      gtk-xft-hintstyle="hintslight";
    };
    gtk4.extraConfig = {
      gtk-button-images=1;
      gtk-menu-images=1;
      gtk-enable-event-sounds=1;
      gtk-enable-input-feedback-sounds=1;
      gtk-xft-antialias=1;
      gtk-xft-hinting=1;
      gtk-xft-hintstyle="hintslight";
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/gtk-4.0/gtk-dark.css".source = "${adw-colors}/themes/solarized-dark/gtk.css";
    ".config/gtk-4.0/gtk-light.css".source = "${adw-colors}/themes/solarized/gtk.css";
  };

  home.sessionVariables = {
    EDITOR = "emacsclient -a '' -r";
    TERMINAL = "kitty";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
