{ config, pkgs, inputs, nvim-nix, ... } @ extra:

{
  imports = [
    ../../home
  ];

  config = {
      # Home Manager needs a bit of information about you and the paths it should
      # manage.
      home.username = "lumpsum";
      home.homeDirectory = "/home/lumpsum";

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

      # The home.packages option allows you to install Nix packages into your
      # environment.
      home.packages = [
            pkgs.discord
            pkgs.spotify
            pkgs.protonup
            # pkgs.steam
            pkgs.cue
            pkgs.fzf
            pkgs.lazygit
            pkgs.jq
            pkgs.ripgrep
            pkgs.tmux
            pkgs.whatsapp-for-linux
            pkgs.zoxide
            pkgs.eza
            pkgs.unzip
            pkgs.kubectl
            pkgs.htop
            pkgs.neofetch
	        pkgs.ghostty
            pkgs.direnv
            # Custom packages
            inputs.zen-browser.packages."x86_64-linux".specific
   	        nvim-nix.packages."x86_64-linux".default

            pkgs.libvirt-glib
        ];

    dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
            autoconnect = ["qemu:///system"];
            uris = ["qemu:///system"];
        };
    };

        # gtk = {
        #     enable = true;
        #     theme = {
        #         package = pkgs.kanagawa-gtk-theme;
        #         name = "Kanagawa";
        #     };
        # };

      # Home Manager is pretty good at managing dotfiles. The primary way to manage
      # plain files is through 'home.file'.
      #home.file = {
      #  ".config/nvim" = {
      #      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
      #  };
      #};

      home.sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/lumpsum/.steam/root/compatibilitytools.d";
        EDITOR = "nvim";
        BROWSER = "firefox";
      };

      programs.git = {
        enable = true;
        userEmail = "vergunstje@hotmail.com";
        userName = "Lumpsum";
        extraConfig = {
            pull.rebase = true;
            init.defaultBranch = "main";
        };
      };

      #services.swaync = {
      #  enable = true;
      #};

      tmux = {
        enable = true;
        theme = extra.theme; 
      };
      zshrc.enable = true;
      k9s.enable = true;
      #wezterm = {
      #  enable = true;
      #  package = inputs.wezterm.packages."x86_64-linux".default;
      #  theme = extra.theme; 
      #};
      yazi.enable = true;
      ohmyposh = {
        enable = true;
        theme = extra.theme; 
      };

      #stylix.targets = {
      #  wezterm.enable = false;
      #  waybar.enable = false;
      #  tmux.enable = false;
      #};

      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;
    };
}
