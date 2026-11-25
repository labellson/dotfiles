{ config, lib, pkgs, pkgsUnstable, ... }:

{
  imports = [
    # this uses gitlab cli to interact with gitlab
    ../glab.nix
  ];

  programs.t3code = {
    enable = true;
    package = pkgsUnstable.t3code.override {
      enableOpencode = true;
    };
  };

}
