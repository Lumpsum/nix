{ config, pkgs, inputs, nvim-nix, ... } @ extra: let
    oldnvim = nvim-nix.packages.aarch64-darwin.default;

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
        pkgs.oh-my-posh
        pkgs.uv
        pkgs.eza
        pkgs.direnv
        pkgs.podman
        pkgs.utm
        pkgs.firefox
        nvim
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
    yazi = {
        enable = true;
        theme = extra.theme;
    };
    zshrc.enable = true;
    # wezterm = {
    #     enable = true;
    #     mac = true;
    #     theme = extra.theme;
    # };
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
        mac = true;
        theme = extra.theme;
    };

    programs.home-manager.enable = true;
}
