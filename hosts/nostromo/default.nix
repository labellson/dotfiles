{ config, pkgs, pkgsUnstable, inputs, ... }:

let
  adw-colors = pkgs.callPackage ./derivations/adw-colors.nix {};
in
{
  imports = [
    ./fish.nix

    ../../home-manager/modules/tinty
    ../../home-manager/modules/gammastep.nix
    ../../home-manager/modules/llm.nix
    ../../home-manager/modules/i18n.nix
    ../../home-manager/modules/voxtype.nix
    ../../home-manager/modules/nh.nix
    ../../home-manager/modules/yazi.nix
    ../../home-manager/modules/darkman.nix
    ../../home-manager/modules/tailscale.nix
    ../../home-manager/modules/nextcloud.nix
    ../../home-manager/modules/fonts.nix

    ../../home-manager/roles/desktop
    ../../home-manager/roles/firefox
    ../../home-manager/roles/emacs
    ../../home-manager/roles/developer
  ];

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

  # gaming
  programs.mangohud.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # TODO: i need to do something to activate firefox wayland
    google-chrome
    obsidian
    element-desktop
    vlc
    cava

    digikam
    darktable

    ncdu
    transmission_4-gtk
    calibre
    libreoffice
    evince
    gnome-calendar

    stremio-linux-shell

    # polish
    adw-colors
    feh

    paisa
    ledger
    hledger
    tradingview
  ];

  services.playerctld.enable = true;

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
      theme = null;
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

  xdg.configFile = {
    "gtk-4.0/gtk-dark.css".source = "${adw-colors}/themes/adw-solarized/gtk4-dark.css";
    "gtk-4.0/gtk-light.css".source = "${adw-colors}/themes/adw-solarized/gtk4-light.css";
    "gtk-3.0/gtk-dark.css".source = "${adw-colors}/themes/adw-solarized/gtk3-dark.css";
    "gtk-3.0/gtk-light.css".source = "${adw-colors}/themes/adw-solarized/gtk3-light.css";
  };
}
