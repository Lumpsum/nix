{
  description = "Main NixOs flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
	    url = "github:nix-community/home-manager";
	    inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:MarceColl/zen-browser-flake";  

    wezterm.url = "github:wez/wezterm?dir=nix";
  };

  outputs = { self, nixpkgs, home-manager, darwin, ... } @ inputs:
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


        darwinConfigurations = {
            rickvergunst = let
                username = "rickvergunst";
            in
                darwin.lib.darwinSystem {
                    system = "aarch64-darwin";
                    modules = [
                        ./hosts/mac/configuration.nix
                        home-manager.darwinModules.home-manager
                        {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.backupFileExtension = "backup";
                            home-manager.extraSpecialArgs = { inherit inputs; };
                            home-manager.users.rickvergunst = import users/${username}/home.nix;
                        }
                    ];
              };
        };
    };
}
