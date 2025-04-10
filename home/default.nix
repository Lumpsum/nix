{ pkgs, ... }:

{
    imports = [
        ./tmux.nix
        ./zshrc.nix
        ./k9s.nix
        ./yazi.nix
        ./wezterm.nix
        ./ohmyposh.nix
        ./ghostty.nix
    ];
}
