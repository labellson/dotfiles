{
  description = "My current dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    paisa = {
      url = "github:ananthakumaran/paisa/v0.6.6";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nfsm-flake = {
      url = "github:gvolpe/nfsm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-unstable, home-manager-unstable, ...}@inputs:
    let
      # path to this repository. I use this to symlink config files to the
      # existing ones in this folder.
      symlinkRoot = "/home/labellson/.dotfiles";
    in
    {
      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "labellson@nostromo" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [./home-manager/.config/home-manager/nostromo/home.nix];
          extraSpecialArgs = {
            inherit inputs symlinkRoot;
            pkgs-unstable = import nixpkgs-unstable {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          };
        };
        # work laptop
        "labellson@lelypop" = home-manager-unstable.lib.homeManagerConfiguration {
          pkgs = nixpkgs-unstable.legacyPackages.x86_64-linux;
          modules = [./home-manager/.config/home-manager/lelypop/home.nix];
          extraSpecialArgs = {
            inherit inputs symlinkRoot;
            # TODO: seems a bit hacky as we already provide unstable but nixpkgs
            # will be updated in the next few days so I can live with it
            pkgs-unstable = import nixpkgs-unstable {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          };
        };
        # motherbase pc
        "labellson@sulaco" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [./home-manager/.config/home-manager/sulaco/home.nix];
        };
      };
    };
}
