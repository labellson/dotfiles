{ config, lib, pkgs, ... }:

{
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
        (plugin {
          owner = "evanlucas";
          repo = "fish-kubectl-completions";
          rev = "ced676392575d618d8b80b3895cdc3159be3f628";
          sha256 = "sha256-OYiYTW+g71vD9NWOcX1i2/TaQfAg+c2dJZ5ohwWSDCc=";
        })
        (plugin {
          owner = "rstacruz";
          repo = "fish-asdf";
          rev = "5869c1b1ecfba63f461abd8f98cb21faf337d004";
          sha256 = "sha256-39L6UDslgIEymFsQY8klV/aluU971twRUymzRL17+6c=";
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

  home.file = {
    ".config/fish/conf.d" = {
      source = ../../../../fish/.config/fish/conf.d;
      recursive = true;
    };

    ".config/fish/functions" = {
      source = ../../../../fish/.config/fish/functions;
      recursive = true;
    };
  };
}
