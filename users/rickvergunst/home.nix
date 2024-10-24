{ config, pkgs, inputs, ... }:

{
    imports = [
      ../../home
    ];

    home.username = "rickvergunst";
    home.stateVersion = "24.05";
    home.homeDirectory = "/Users/rickvergunst";

    home.file = {
        ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
        # ".config/nix".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nix";
        # ".config/starship".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/starship";
    };

    home.packages = with pkgs; [
        zoxide
        fd
        google-cloud-sdk
        dive
        cue
        fzf
        neovim
        httpie
        lazygit
        kind
        opentofu
        ripgrep
        tmux
        watch
        pipx
        starship
        go
        presenterm
        oh-my-posh
        uv
        eza
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
    wezterm = {
        enable = true;
        mac = true;
    };
    tmux.enable = true;
    ohmyposh.enable = true;

    programs.home-manager.enable = true;
}
