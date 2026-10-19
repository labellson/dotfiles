{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    (anki.withAddons [
      ankiAddons.anki-quizlet-importer-extended
      ankiAddons.review-heatmap
    ])
  ];
}
