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

    stylix.url = "github:danth/stylix";

    nvim-nix.url = "github:Lumpsum/nvim-nix";
  };

  outputs = { self, nixpkgs, home-manager, darwin, nvim-nix, ... } @ inputs:
    {
        nixosConfigurations = {
            lumpsum = let
                username = "lumpsum";
            in
            nixpkgs.lib.nixosSystem {
                modules = [
                    ./hosts/home/configuration.nix
                    inputs.stylix.nixosModules.stylix
                
                    home-manager.nixosModules.home-manager
                    {
                        home-manager.extraSpecialArgs = { 
                            inherit inputs; 
			    inherit nvim-nix;
                            theme = "kanagawa";
                        };
                        home-manager.users.lumpsum = import users/${username}/home.nix;
                    }
                ];
            };
        };


        darwinConfigurations = {
            rickvergunst = let
                username = "rickvergunst";
            in
                darwin.lib.darwinSystem rec {
                    system = "aarch64-darwin";
                    modules = [
                        ./hosts/mac/configuration.nix
                        home-manager.darwinModules.home-manager
                        {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.backupFileExtension = "backup";
                            home-manager.extraSpecialArgs = { 
                                inherit inputs;
                                theme = "kanagawa";
                                nvim-nix = nvim-nix.packages.aarch64-darwin.default;
                            };
                            home-manager.users.rickvergunst = import users/${username}/home.nix;
                        }
                    ];
              };
        };
	    homeConfigurations = {
      		# FIXME replace with your username@hostname
      		"lumpsum@Lumpsum" = home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
                extraSpecialArgs = {
                    inherit inputs;
                    theme = "kanagawa"; 
                };
                # > Our main home-manager configuration file <
                modules = [
                    users/arch/home.nix
                    {
                        home.packages = [ nvim-nix.packages.x86_64-linux.default ];
                    }
                ];
            };
        };

    };
}
