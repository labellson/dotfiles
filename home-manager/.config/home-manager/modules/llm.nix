{ config, lib, pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs-unstable; [
    llama-cpp-vulkan
  ];
}
