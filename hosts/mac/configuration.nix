{ pkgs, ... }: 

{
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    environment.systemPackages = [
        pkgs.vim
    ];

    # Auto upgrade nix package and the daemon service.
    # services.nix-daemon.enable = true;
    # services.karabiner-elements.enable = true;
    # nix.package = pkgs.nix;
    ids.gids.nixbld = 350;

    # Necessary for using flakes on this system.
    nix.settings.experimental-features = "nix-command flakes";

    # Create /etc/zshrc that loads the nix-darwin environment.
    programs.zsh.enable = true;  # default shell on catalina
    # programs.fish.enable = true;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 4;

    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = "aarch64-darwin";
    nixpkgs.config.allowBroken = true;

    users.users.rickvergunst = {
        name = "rickvergunst";
        home = "/Users/rickvergunst";
    };

    homebrew.enable = true;
    homebrew.taps = [];
    homebrew.brews = [
        "helm"
    ];
    homebrew.casks = [
        "dbeaver-community"
        "font-hack-nerd-font"
        "rectangle"
        "slack"
        "whatsapp"
        "discord"
        "spotify"
        "nikitabobko/tap/aerospace"
        "ghostty"
        "zen-browser"
        "signal"
        "vial"
        "tailscale"
    ];
}
