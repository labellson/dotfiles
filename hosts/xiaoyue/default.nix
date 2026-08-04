{ config, lib, pkgs, ... }:

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
    ../../home-manager/modules/nextcloud.nix
    ../../home-manager/modules/fonts.nix

    ../../home-manager/roles/desktop
    ../../home-manager/roles/firefox
    ../../home-manager/roles/emacs
    ../../home-manager/roles/developer
  ];
}
