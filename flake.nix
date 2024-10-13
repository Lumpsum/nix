{
  description = "Main NixOs flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
	    url = "github:nix-community/home-manager";
	    inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:MarceColl/zen-browser-flake";  
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      # system = "x86_64-linux";
      # pkgs = nixpkgs.legacyPackages.${system};
    in
    {
        nixosConfigurations = {
            lumpsum = let
                username = "lumpsum";
            in
            nixpkgs.lib.nixosSystem {
                modules = [
                    ./hosts/home/configuration.nix
                
                    home-manager.nixosModules.home-manager
                    {
                        home-manager.extraSpecialArgs = { inherit inputs; };
                        home-manager.users.lumpsum = import users/${username}/home.nix;
                    }
                ];
            };
        };
    };
}
