{ config, pkgs, lib, symlinkRoot, ... }:

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

  home.packages = with pkgs; [
    kitty
    ripgrep
    mosh
    btop

    niri

    firefox
    obsidian
    vlc
    overskride
    noisetorch
    pavucontrol
    dconf

    neovim
    emacs-pgtk
    nil
    nodejs # just to install lsp-servers
    jq

    # needed by doom emacs
    fd
    gcc
    gnumake
    cmakeMinimal
    (aspellWithDicts (dicts: with dicts; [en es]))
    shellcheck
    nixfmt-rfc-style

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
