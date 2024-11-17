{ pkgs, lib, config, ... }:
let
    kanagawa = pkgs.tmuxPlugins.mkTmuxPlugin
    {
        pluginName = "kanagawa";
        version = "unstable-2024-10-09";
        src = pkgs.fetchFromGitHub {
            owner = "Nybkox";
            repo = "tmux-kanagawa";
            rev = "fc95d797ba24536bffe3f2b2101e7d7ec3e5aaa1";
            sha256 = "sha256-vCgqXrT7qukAmx/DUu4H6CT997pdiKOKA0CjLTWEALQ=";
        };
    };

    dracula = pkgs.tmuxPlugins.mkTmuxPlugin
    {
        pluginName = "dracula";
        version = "unstable-11-16";
        src = pkgs.fetchFromGitHub {
            owner = "dracula";
            repo = "tmux";
            rev = "ea1a45d1c623cd05f1c42abace905ecc8ecaf058";
            sha256 = "sha256-1jW8L2/Z0/pLHrvj7dXiLQ9uxQ7T5Vn9cW7+jPxwJPQ=";
        };
    };
in
{
    options = {
        tmux.enable = lib.mkEnableOption "enable tmux";
        tmux.theme = lib.mkOption {
            type = lib.types.str;
            default = "kanagawa";
        };
    };

    config = lib.mkIf config.tmux.enable {
        programs.tmux = {
            enable = true;
            terminal = "tmux-256-color";
            plugins = with pkgs;
                [
                    tmuxPlugins.vim-tmux-navigator
                    tmuxPlugins.yank
                    tmuxPlugins.sensible
                    (if (config.tmux.theme == "monoglow") then
                        {
                            plugin = dracula;
                            extraConfig = ''
                            set -g @dracula-plugins "git battery time"

                            set -g @dracula-time-colors "gray2 fg"
                            set -g @dracula-battery-colors "gray3 fg"
                            set -g @dracula-git-colors "gray4 fg"

                            set -g @dracula-show-powerline true 
                            set -g @dracula-day-month true
                            set -g @dracula-git-no-repo-message ""
                            set -g @dracula-time-format "%F %R"
                            set -g @dracula-show-fahrenheit false
                            set -g @dracula-show-empty-plugins false
                            set -g @dracula-ignore-window-colors false
                            set -g @dracula-show-left-icon session
                            set -g @dracula-show-empty-plugins false
                            set -g @dracula-left-icon-padding 0
                            set -g @dracula-powerline-bg-transparent true

                            set -g @dracula-colors "
                            white='#f8f8f2'
                            dark_gray='#121212'
                            gray='#191919'
                            light_purple='#2a2a2a'
                            dark_purple='#7a7a7a'
                            cyan='#8be9fd'
                            green='#555555'
                            orange='#ffb86c'
                            red='#ff5555'
                            pink='#ff79c6'
                            yellow='#1bfd9c'

                            gray1='#080808'
                            gray2='#191919'
                            gray3='#2a2a2a'
                            gray4='#444444'
                            gray5='#555555'
                            gray6='#7a7a7a'
                            gray7='#aaaaaa'
                            gray8='#cccccc'
                            gray9='#dddddd'
                            gray10='#f1f1f1'
                            fg='#cccccc'
                            "
                            '';
                        }
                    else 
                        {
                            plugin = kanagawa;
                            extraConfig = ''

                            set -g @kanagawa-plugins "git battery time"
                            set -g @kanagawa-show-powerline true 
                            set -g @kanagawa-day-month true
                            set -g @kanagawa-git-no-repo-message ""
                            set -g @kanagawa-time-format "%F %R"
                            set -g @kanagawa-show-fahrenheit false
                            set -g @kanagawa-ignore-window-colors false
                            set -g @kanagawa-show-empty-plugins false
                            set -g @kanagawa-left-icon-padding 0
                            set -g @kanagawa-powerline-bg-transparent true
                            '';
                        }
                    )
                ];
            extraConfig = ''
            set -sg default-terminal "screen-256color"
            set -sa terminal-overrides ",xterm*:Tc"

            set -g prefix C-a
            unbind C-b
            bind-key C-a send-prefix

            # Rebind opening panes
            unbind %
            bind | split-window -h
            unbind '"'
            bind - split-window -v

            # Refresh tmux conf
            unbind r
            bind r source-file ~/.config/tmux/tmux.conf

            bind -r j resize-pane -D 5
            bind -r k resize-pane -U 5
            bind -r l resize-pane -R 5
            bind -r h resize-pane -L 5

            bind -r m resize-pane -Z


            set -g mouse on

            set-window-option -g mode-keys vi

            bind-key -T copy-mode-vi 'v' send -X begin-selection
            bind-key -T copy-mode-vi 'y' send -X copy-selection

            unbind -T copy-mode-vi MouseDragEnd1Pane
            '';
        };
    };
}
