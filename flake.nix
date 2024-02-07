{
  description = "My current dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    paisa = {
      url = "github:ananthakumaran/paisa";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ...}@inputs:
    {
      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "labellson@nostromo" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [./home-manager/.config/home-manager/nostromo/home.nix];
          extraSpecialArgs = { inherit inputs; };
        };
        # work laptop
        "labellson@vostok" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-darwin;
          modules = [./home-manager/.config/home-manager/vostok/home.nix];
        };
        # work server
        "dani@shiva" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [./home-manager/.config/home-manager/shiva/home.nix];
        };
      };
    };
}
