{
  description = "My current dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nfsm-flake = {
      url = "github:gvolpe/nfsm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      # we pin to cachix branch, because it always points to the latest cached
      # commit
      url = "github:noctalia-dev/noctalia/cachix";
      # we don't follow nixpkgs because this will invalidate the cache
    };
    voxtype = {
      url = "github:peteonrails/voxtype";
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
        # these functions create attrSets to files outside of the nix store
        makeLink = mkOutOfStoreSymlink: (name: mkOutOfStoreSymlink (dlsFuncs.toSrcFile name));
        makeLinkFile = mkOutOfStoreSymlink: (name: {
          ${name}.source = (dlsFuncs.makeLink mkOutOfStoreSymlink) name;
        });
        mkLink = mkOutOfStoreSymlink: (name: mkOutOfStoreSymlink (dlsFuncs.toSrcFile name));
        # TODO: migrate from this function to the new mkSymlinkPath
        mkSymlink = mkOutOfStoreSymlink: (name: {
          ${name} = {
            source = (dlsFuncs.mkLink mkOutOfStoreSymlink) name;
            # link directories recursively. Has no effects on files
            recursive = true;
          };
        });

        # After some time thinking this allows me to pass relative paths to real
        # dotfiles in the repo. This way I always know if I'm passing a
        # real dotfile or not
        mkSymlinkPath = mkOutOfStoreSymlink: lib: self: (path:
        let
          pathStr =
            if builtins.pathExists path
            then toString path
            # "${path}" already gives a nice error by itself. The throw is
            # actually not necessary, but the intention of the code looks
            # clear this way
            else throw "${path} does not exists";
          storeBasePathStr = "${toString self}/";
          name = lib.removePrefix storeBasePathStr pathStr;
        in
        {
          ${name} = {
            source = (dlsFuncs.mkLink mkOutOfStoreSymlink) name;
            # link directories recursively. Has no effects on files
            recursive = true;
          };
        });
      };

      pkgsUnstable = import nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };

      vars = {
        user = "labellson";
      };

      mkHomeManagerConfiguration =
        {
          path,
          extraModules ? [ ],
        }:
        home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {
            inherit inputs pkgsUnstable dlsFuncs vars;
          };
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./home-manager/common
            ./hosts/common
            path
          ]
          ++ extraModules;
        };
    in
    {
      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "labellson@nostromo" = mkHomeManagerConfiguration {
          path = ./hosts/nostromo;
        };
        # work laptop
        "labellson@lelypop" = mkHomeManagerConfiguration {
          path = ./hosts/lelypop;
        };
        # motherbase pc
        "labellson@sulaco" = mkHomeManagerConfiguration {
            path = ./hosts/sulaco;
        };
        "labellson@xiaoyue" = mkHomeManagerConfiguration {
          path = ./hosts/xiaoyue;
        };
      };
    };

    nixConfig = {
        extra-substituters = [ "https://noctalia.cachix.org" ];
        extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
    };
}
