{
  description = "My current dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-25-05.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager-25-05 = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-25-05";
    };
    paisa = {
      url = "github:ananthakumaran/paisa/v0.6.6";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-25-05, home-manager-25-05,...}@inputs:
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
        # motherbase pc
        "labellson@sulaco" = home-manager-25-05.lib.homeManagerConfiguration {
          pkgs = nixpkgs-25-05.legacyPackages.x86_64-linux;
          modules = [./home-manager/.config/home-manager/sulaco/home.nix];
        };
      };
    };
}
