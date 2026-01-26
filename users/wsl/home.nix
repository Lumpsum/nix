{ config, pkgs, inputs, nvim-nix, sops, ... } @ extra: let
    oldnvim = nvim-nix.packages.x86_64-linux.default;

    inherit (oldnvim.passthru) utils;
    nvim = oldnvim.override (prev: {
        name = "nvim";
        packageDefinitions = prev.packageDefinitions // {
            nvim = utils.mergeCatDefs prev.packageDefinitions.nvim ({pkgs, ... }: {
                categories = {
                    colorscheme = extra.theme;
                };
            });
        };
    });
in
{
  imports = [
    ../../home
    inputs.sops-nix.homeManagerModules.sops
  ];

  config = {
      # Home Manager needs a bit of information about you and the paths it should
      # manage.
      home.username = "wsl";
      home.homeDirectory = "/home/wsl";

      nixpkgs.config.allowUnfree = true;

      # This value determines the Home Manager release that your configuration is
      # compatible with. This helps avoid breakage when a new Home Manager release
      # introduces backwards incompatible changes.
      #
      # You should not change this value, even if you update Home Manager. If you do
      # want to update the value, then make sure to first check the Home Manager
      # release notes.
      home.stateVersion = "24.11"; # Please read the comment before changing.

      nixpkgs.overlays = [
        (final: prev: {
            _7zz = prev._7zz.override { useUasm = true; };
        })
      ];

      sops = {
        age.keyFile = "/home/wsl/.config/sops/age/keys.txt";

        defaultSopsFile = ../../secrets.yaml;
        defaultSopsFormat = "yaml";

        secrets.gemini_key = { };
        secrets.chatgpt_key = { };
      };

      # The home.packages option allows you to install Nix packages into your
      # environment.
      home.packages = [
            pkgs.cue
            pkgs.fzf
            pkgs.lazygit
            pkgs.tmux
            pkgs.zoxide
            pkgs.eza
            pkgs.unzip
            pkgs.kubectl
            pkgs.htop
            pkgs.neofetch
            pkgs.direnv
            # Custom packages
            nvim
        ];

      # Home Manager is pretty good at managing dotfiles. The primary way to manage
      # plain files is through 'home.file'.
      #};

      home.sessionVariables = {
        EDITOR = "nvim";
        BROWSER = "firefox";
      };

      programs.git = {
        enable = true;
        settings = {
            pull.rebase = true;
            init.defaultBranch = "main";
            user = {
                email = "vergunstje@hotmail.com";
                name = "Lumpsum";
            };
        };
      };

    k9s.enable = true;
    yazi = {
        enable = true;
        theme = extra.theme;
    };
    zshrc.enable = true;
    tmux = {
        enable = true;
        theme = extra.theme;
    };
    ohmyposh = {
        enable = true;
        theme = extra.theme;
    };
    ghostty = {
        enable = true;
        mac = false;
        theme = extra.theme;
    };

      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;
    };
}
