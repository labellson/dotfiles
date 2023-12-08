{
  description = "My current dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager}:
    {
      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "labellson@vostok" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-darwin;
          modules = [./home-manager/home.nix];
        };
      };
    };
}
