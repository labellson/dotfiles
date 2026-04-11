{
  description = "My current dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nfsm-flake = {
      url = "github:gvolpe/nfsm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-unstable, ...}@inputs:
    let
      # path to this repository. I use this to symlink config files to the
      # existing ones in this folder.
      symlinkRoot = "/home/labellson/.dotfiles";
      # set of helper functions I pass to other modules
      dlsFuncs = {
        # make helper functions to link files
        toSrcFile = name: "${symlinkRoot}/${name}";

        # I have not found a better name to this make* functions
        # this functions create attrSets to files outside of the nix store
        makeLink = mkOutOfStoreSymlink: (name: mkOutOfStoreSymlink (dlsFuncs.toSrcFile name));
        makeLinkFile = mkOutOfStoreSymlink: (name: {
          ${name}.source = (dlsFuncs.makeLink mkOutOfStoreSymlink) name;
        });
        makeLinkDir = mkOutOfStoreSymlink: (name: {
          ${name} = {
            source = (dlsFuncs.makeLink mkOutOfStoreSymlink) name;
            recursive = true;
          };
        });
      };

      pkgs-unstable = import nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in
    {
      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "labellson@nostromo" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [./home-manager/.config/home-manager/nostromo/home.nix];
          extraSpecialArgs = {
            inherit inputs symlinkRoot pkgs-unstable dlsFuncs;
          };
        };
        # work laptop
        "labellson@lelypop" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [./home-manager/.config/home-manager/lelypop/home.nix];
          extraSpecialArgs = {
            inherit inputs symlinkRoot pkgs-unstable dlsFuncs;
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
