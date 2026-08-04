{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    (python313.withPackages(ps: with ps; [requests ipython]))
    uv
  ];
}
