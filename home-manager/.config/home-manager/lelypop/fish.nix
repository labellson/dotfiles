{ config, lib, pkgs, ... }:

{
  programs.fish = {
    shellAbbrs = {
      hms = "home-manager switch --flake ~/.dotfiles#labellson@lelypop";
      doom = "~/.config/emacs/bin/doom";

      # databricks related
      dbrlj = "databricks --profile dbr-sphere-dev jobs list -o json | jq '.[] | {job_id: .job_id, name: .settings.name}'";
      dbrljtp = "databricks --profile dbr-sphere-dev jobs list -o json | jq '.[] | select(.settings.tags.tp_ticket == $tp_ticket) | {job_id: .job_id, name: .settings.name, tp_ticket: .settings.tags.tp_ticket}' --arg tp_ticket";
      wdbrj = "watch -c -n 60 databricks --profile dbr-sphere-dev jobs list-runs --job-id";

      dbrljprod = "databricks --profile dbr-sphere-prd jobs list -o json | jq '.[] | {job_id: .job_id, name: .settings.name}'";
      dbrljtpprod = "databricks --profile dbr-sphere-prd jobs list -o json | jq '.[] | select(.settings.tags.tp_ticket == $tp_ticket) | {job_id: .job_id, name: .settings.name, tp_ticket: .settings.tags.tp_ticket}' --arg tp_ticket";
      wdbrjprod = "watch -c -n 60 databricks --profile dbr-sphere-prd jobs list-runs --job-id";
    };
  };
}
