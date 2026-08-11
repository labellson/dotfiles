{ config, lib, pkgs, vars, dlsFuncs, inputs, ... }:

let
  inherit (config.lib.file) mkOutOfStoreSymlink;

  mkSymlinkPath = dlsFuncs.mkSymlinkPath mkOutOfStoreSymlink lib inputs.self;
  confLinks = lib.mergeAttrsList (
    lib.map mkSymlinkPath [
      ../../nix/nix.conf
      ../../nixpkgs/config.nix
    ]
  );
in
{
  home = {
    username = "${vars.user}";
    homeDirectory = "/home/${vars.user}";
  };

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.git = {
    enable = true;
    settings = {
      user ={
        name = "Daniel Laguna";
        email = "labellson@fastmail.com";
      };
      init.defaultBranch = "main";
    };
  };

  xdg.configFile = confLinks;

  # Let Home Manager install and manage itself and enable git
  programs.home-manager.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05"; # Please read the comment before changing.
}
