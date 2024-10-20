{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../home
  ];

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
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
        pkgs.discord
        pkgs.spotify
        pkgs.protonup
        pkgs.steam
        pkgs.cue
        pkgs.fzf
        pkgs.lazygit
        pkgs.jq
        pkgs.kind
        pkgs.opentofu
        pkgs.ripgrep
        pkgs.tmux
        pkgs.whatsapp-for-linux
        pkgs.watch
        pkgs.docker
        pkgs.zoxide
        pkgs.eza
        pkgs.mangohud
        pkgs.go
        pkgs.unzip
        pkgs.nodePackages.npm
        pkgs.gnumake
        pkgs.kubectl
        pkgs.htop
        pkgs.kitty
        pkgs.wofi
        pkgs.waybar
        pkgs.fd
        pkgs.kdePackages.qtsvg
        pkgs.hyprshot
        pkgs.neofetch
        pkgs.nautilus
        pkgs.uv
        (pkgs.nerdfonts.override { fonts = [ "Hack" ]; })

        # Custom packages
        inputs.zen-browser.packages."x86_64-linux".specific
    ];

    gtk = {
        enable = true;
        theme = {
            package = pkgs.kanagawa-gtk-theme;
            name = "Kanagawa";
        };
    };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
    };
  };

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/lumpsum/.steam/root/compatibilitytools.d";
    EDITOR = "nvim";
    BROWSER = "firefox";
  };

  programs.git = {
	enable = true;
	userEmail = "vergunstje@hotmail.com";
	userName = "Lumpsum";
  };

  services.swaync = {
    enable = true;
  };

  tmux.enable = true;
  zshrc.enable = true;
  k9s.enable = true;
  wezterm = {
    enable = true;
    package = inputs.wezterm.packages."x86_64-linux".default;
  };
  yazi.enable = true;
  ohmyposh.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
