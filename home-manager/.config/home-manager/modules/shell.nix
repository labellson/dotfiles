{ config, lib, pkgs, symlinkRoot, ... }:

let
  # import some useful functions
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (lib) map mergeAttrsList;

  # make helper functions to link files
  toSrcFile = name: "${symlinkRoot}/${name}";
  link = name: mkOutOfStoreSymlink (toSrcFile name);

  # use previous functions to create helper functions to create attrSets
  linkFile = name: {
    ${name}.source = link name;
  };

  confFiles = map linkFile [
    "fish/fish_plugins"
    "fish/conf.d/dls-env.fish"
    "fish/conf.d/dls-path.fish"
    "fish/functions/dls-mkcd.fish"
    "fish/functions/dls-t.fish"
    "fish/functions/dotenv.fish"
  ];

  confLinks = mergeAttrsList confFiles;
in
{
  imports = [
    ./shell-starship.nix
  ];

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
    silent = true;
  };

  programs.bash = {
      enable = true;
      bashrcExtra = builtins.readFile ../../../../bash/.bashrc;
  };

  programs.fish = {
    enable = true;
    plugins = let plugin = {owner, repo, rev, sha256} :
      {
        name = repo;
        src = pkgs.fetchFromGitHub {inherit owner repo rev sha256;};
      };
      in
      [
        {
          name = "z";
          src = pkgs.fishPlugins.z.src;
        }
        {
          name = "done";
          src = pkgs.fishPlugins.done.src;
        }
        {
          name = "autopair.fish";
          src = pkgs.fishPlugins.autopair.src;
        }
        {
          name = "puffer-fish";
          src = pkgs.fishPlugins.puffer.src;
        }
        {
          name = "humantime.fish";
          src = pkgs.fishPlugins.humantime-fish.src;
        }
        (plugin {
          owner = "gazorby";
          repo = "fish-abbreviation-tips";
          rev = "8ed76a62bb044ba4ad8e3e6832640178880df485";
          sha256 = "sha256-F1t81VliD+v6WEWqj1c1ehFBXzqLyumx5vV46s/FZRU=";
        })
      ];

    shellAbbrs = {
      # git abbreviations
      gcm = "git commit -m";
      gc = "git checkout";
      gp = "git push";
      gpo = "git push origin";
      gpl = "git pull";
      gplo = "git pull origin";
      gploc = "git pull origin (git branch --show-current)";
      gf = "git fetch";
      gfo = "git fetch origin";
      gs = "git status";
      glol = "git log --oneline --decorate --graph";
      glola = "git log --oneline --decorate --graph --all";
    };
  };

  xdg.configFile = confLinks;
}
