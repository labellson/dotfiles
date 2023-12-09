{ config, lib, pkgs, ... }:

{
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
        (plugin {
          owner = "jethrokuan";
          repo = "z";
          rev = "85f863f20f24faf675827fb00f3a4e15c7838d76";
          sha256 = "sha256-+FUBM7CodtZrYKqU542fQD+ZDGrd2438trKM0tIESs0=";
        })
        (plugin {
          owner = "jorgebucaran";
          repo = "hydro";
          rev = "41b46a05c84a15fe391b9d43ecb71c7a243b5703";
          sha256 = "sha256-zmEa/GJ9jtjzeyJUWVNSz/wYrU2FtqhcHdgxzi6ANHg=";
        })
        (plugin {
          owner = "franciscolourenco";
          repo = "done";
          rev = "fbea3f682f9f32d957946490436e9dde8a67c367";
          sha256 = "sha256-BGHfwKoMfOZUsa05kEt8W2luc1aC3Su/OyaGmcb4UiI=";
        })
        (plugin {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "4d1752ff5b39819ab58d7337c69220342e9de0e2";
          sha256 = "sha256-qt3t1iKRRNuiLWiVoiAYOu+9E7jsyECyIqZJ/oRIT1A=";
        })
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
        (plugin {
          owner = "nickeb96";
          repo = "puffer-fish";
          rev = "5d3cb25e0d63356c3342fb3101810799bb651b64";
          sha256 = "sha256-aPxEHSXfiJJXosIm7b3Pd+yFnyz43W3GXyUB5BFAF54=";
        })
      ];
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
