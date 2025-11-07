{ config, pkgs, inputs, ... }:

let
  adw-colors = pkgs.callPackage ../derivations/adw-colors.nix {};
in
{
  imports = [
    ../modules/shell.nix
    ./fish.nix
    ./desktop/x11.nix
    ./desktop/wayland.nix
    ../modules/xdg.nix
    ../modules/tinty
  ];

  # TODO: test if it works and submit PR to nixpkgs
  nixpkgs.overlays = [
    (self: super: {
      darkman = super.darkman.overrideAttrs (oldAttrs: rec {
        version = "2.2.0";
        src = pkgs.fetchFromGitLab {
          owner = "WhyNotHugo";
          repo = "darkman";
          rev = "v${version}";
          hash = "sha256-Kpuuxxwn/huA5WwmnVGG0HowNBGyexDRpdUc3bNmB18=";
        };
        patches = [ ../packages/darkman/makefile.patch ];

        postPatch = ''
          substituteInPlace contrib/darkman.service \
            --replace-fail /usr/bin/darkman $out/bin/darkman
          substituteInPlace contrib/dbus/nl.whynothugo.darkman.service \
            --replace-fail /usr/bin/darkman $out/bin/darkman
          substituteInPlace contrib/dbus/org.freedesktop.impl.portal.desktop.darkman.service \
            --replace-fail /usr/bin/darkman $out/bin/darkman
        '';

        vendorHash = "sha256-QO+fz8m2rILKTokimf+v4x0lon5lZy7zC+5qjTMdcs0=";
      });
    })
  ];

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "labellson";
  home.homeDirectory = "/home/labellson";

  # Config keyboard keymap
  # TODO: is this only for X11?? Doesn't seem to apply in wayland (sway)
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

  # polkit
  services.polkit-gnome.enable = true;

  # gnupg
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableFishIntegration = true;
    pinentry.package = pkgs.pinentry-gnome3;
  };

  services.darkman.enable = true;

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
    btop

    pavucontrol

    # TODO: i need to do something to activate firefox wayland
    firefox
    google-chrome
    obsidian  # says that electron 24 is an insecure package
    element-desktop
    telegram-desktop
    vlc

    ncdu
    transmission_4-gtk
    calibre
    libreoffice
    evince

    emacs-pgtk  # with native wayland support
    neovim
    git-lfs
    git-filter-repo
    nil  # nix language server
    nodejs # just to install lsp-servers
    docker-compose
    jq

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
    (python313.withPackages(ps: with ps; [requests ipython]))
    uv

    stremio

    # polish
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
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };
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
    gtk3 = {
      extraConfig = {
        gtk-button-images=1;
        gtk-menu-images=1;
        gtk-enable-event-sounds=1;
        gtk-enable-input-feedback-sounds=1;
        gtk-xft-antialias=1;
        gtk-xft-hinting=1;
        gtk-xft-hintstyle="hintslight";
      };
    };
    gtk4 = {
      extraConfig = {
        gtk-button-images=1;
        gtk-menu-images=1;
        gtk-enable-event-sounds=1;
        gtk-enable-input-feedback-sounds=1;
        gtk-xft-antialias=1;
        gtk-xft-hinting=1;
        gtk-xft-hintstyle="hintslight";
      };
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
    ".config/gtk-4.0/gtk-dark.css".source = "${adw-colors}/themes/adw-solarized/gtk4-dark.css";
    ".config/gtk-4.0/gtk-light.css".source = "${adw-colors}/themes/adw-solarized/gtk4-light.css";
    ".config/gtk-3.0/gtk-dark.css".source = "${adw-colors}/themes/adw-solarized/gtk3-dark.css";
    ".config/gtk-3.0/gtk-light.css".source = "${adw-colors}/themes/adw-solarized/gtk3-light.css";
  };

  home.sessionVariables = {
    EDITOR = "emacsclient -a '' -r";
    TERMINAL = "kitty";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
