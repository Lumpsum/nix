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

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # wezterm.url = "github:wez/wezterm?dir=nix";

    # stylix.url = "github:danth/stylix";

    nvim-nix.url = "github:Lumpsum/nvim-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      darwin,
      nvim-nix,
      ...
    }@inputs:
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;

      nixosConfigurations = {
        lumpsum =
          let
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
        rickvergunst =
          let
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
                  inherit nvim-nix;
                  theme = "ashen";
                };
                home-manager.users.rickvergunst = import users/${username}/home.nix;
              }
            ];
          };
      };
      homeConfigurations = {
        "lumpsum@Lumpsum" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = {
            inherit inputs;
            inherit nvim-nix;
            theme = "ashen";
          };
          modules = [
            users/arch/home.nix
          ];
        };
      };

    };
}
