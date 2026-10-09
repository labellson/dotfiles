{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    (python314.withPackages(ps: with ps; [requests ipython]))
    uv
  ];
}
