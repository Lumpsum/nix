{ config, pkgs, inputs, ... } @ extra:

{
    imports = [
      ../../home
    ];

    home.username = "rickvergunst";
    home.stateVersion = "24.11";
    home.homeDirectory = "/Users/rickvergunst";

    home.packages = [
        pkgs.zoxide
        pkgs.fd
        pkgs.google-cloud-sdk
        pkgs.dive
        pkgs.cue
        pkgs.fzf
        pkgs.httpie
        pkgs.lazygit
        pkgs.kind
        pkgs.opentofu
        pkgs.ripgrep
        pkgs.tmux
        pkgs.watch
        pkgs.pipx
        pkgs.starship
        pkgs.go
        pkgs.presenterm
        pkgs.oh-my-posh
        pkgs.uv
        pkgs.eza
        pkgs.direnv
        pkgs.podman
        extra.nvim-nix
        pkgs.utm
    ];

    programs.git = {
        enable = true;
        userEmail = "vergunstje@hotmail.com";
        userName = "Lumpsum";
    };

    home.sessionVariables = {
        EDITOR = "nvim";
        BROWSER = "zen-browser";
    };

    k9s.enable = true;
    yazi.enable = true;
    zshrc.enable = true;
    # wezterm = {
    #     enable = true;
    #     mac = true;
    #     theme = extra.theme;
    # };
    tmux = {
        enable = true;
        # theme = extra.theme;
        theme = "ashen";
    };
    ohmyposh = {
        enable = true;
        theme = extra.theme;
    };
    ghostty = {
        enable = true;
        mac = true;
        theme = "ashen";
    };

    programs.home-manager.enable = true;
}
