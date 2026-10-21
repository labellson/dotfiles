{ config, pkgs, pkgsUnstable, lib, dlsFuncs, ... }:

{
  imports = [
    ./home-configuration.nix

    ../../home-manager/modules/tinty
    ../../home-manager/modules/llm.nix
    ../../home-manager/modules/i18n.nix
    ../../home-manager/modules/voxtype.nix
    ../../home-manager/modules/nh.nix
    ../../home-manager/modules/yazi.nix
    ../../home-manager/modules/darkman.nix
    ../../home-manager/modules/syncthing.nix
    ../../home-manager/modules/tailscale.nix
    ../../home-manager/modules/fonts.nix

    ../../home-manager/roles/desktop
    ../../home-manager/roles/firefox
    ../../home-manager/roles/emacs
    ../../home-manager/roles/developer
  ];

  # gtk = {
  #   enable = true;
  #   theme = {
  #       package = pkgs.adw-gtk3;
  #       name = "adw-gtk3";
  #   };
  # };
  # xdg = {
  #   enable = true;
  #   mime.enable = true;
  #   # fix screensharing: https://cashmere.rs/blog/20250612002456-how-to-fix-screensharing-for-niri-wm-under-nixos/
  #   portal = {
  #     enable = true;
  #     extraPortals = with pkgs; [
  #       xdg-desktop-portal-gnome
  #       xdg-desktop-portal-gtk
  #       xdg-desktop-portal-wlr
  #     ];
  #     config = {
  #       common = {
  #         default = [ "gtk" ];
  #       };
  #       niri = {
  #       default = [
  #           "gtk"
  #           "gnome"
  #       ];
  #       "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
  #       "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
  #       };
  #     };
  #   };
  #   # fix systemd reads portal systems: https://discourse.nixos.org/t/configuring-xdg-desktop-portal-with-home-manager-on-ubuntu-hyprland-via-nixgl/65287/6
  #   configFile = {
  #     "systemd/user.conf".text = ''
  #         [Manager]
  #         ManagerEnvironment="XDG_DATA_DIRS=/nix/var/nix/profiles/default/share:/home/labellson/.nix-profile/share:/usr/share/ubuntu:/usr/local/share:/usr/share:/var/lib/snapd/desktop:/usr/local/share:/usr/share:/var/lib/snapd/desktop:/home/labellson/.nix-profile/share:/nix/var/nix/profiles/default/share:/home/labellson/.nix-profile/share:/nix/var/nix/profiles/default/share"
  #     '';
  #   } // confLinks;
  # };
}
