{ config, pkgs, ... }:

let
  # so happy to make my 1st derivation
  polybar-pulseaudio-control = pkgs.callPackage ./polybar-pulseaudio-control.nix {};
  adw-colors = pkgs.callPackage ./adw-colors.nix {};
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "labellson";
  home.homeDirectory = "/home/labellson";

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
  xsession.windowManager.command = "startx";

  programs.bash = {
      enable = true;
      bashrcExtra = ''
        . ~/.dotfiles/bash/.bashrc
      '';
    };

  # allow fontconfig to discover fonts installed through home.packages
  fonts.fontconfig.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    fish
    kitty
    ripgrep
    killall

    (polybar.override {i3Support = true;})
    polybar-pulseaudio-control
    rofi
    rofi-bluetooth
    bc # needed by rofi-bluetooth

    pavucontrol

    firefox
    darkman
    arandr
    ncdu

    xfce.thunar
    xfce.thunar-volman

    emacs29
    neovim

    stremio
    steam

    # fonts
    nerdfonts
    fantasque-sans-mono

    # polish
    lxappearance
    adw-colors

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

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

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/labellson/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
