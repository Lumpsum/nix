{ pkgs, lib, config, ... }:

{
    options = {
        zshrc.enable = lib.mkEnableOption "enable zshrc";
    };

    config = lib.mkIf config.zshrc.enable {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        initContent = ''
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
        [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

        eval "$(zoxide init zsh)"

        source <(fzf --zsh)

        if command -v pyenv 2>&1 >/dev/null
        then
            export PYENV_ROOT="$HOME/.pyenv"
            [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
            eval "$(pyenv init -)"
        fi

        function y() {
            local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
            yazi "$@" --cwd-file="$tmp"
            if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
                builtin cd -- "$cwd"
            fi
            rm -f -- "$tmp"
        }

        eval "$(direnv hook zsh)"
        '';

        shellAliases = {
            l = "eza -l --icons --git -a";
            lt = "eza --tree --level=2 --long --icons --git";
            ltree = "eza --tree --level=2  --icons --git";
        };

        oh-my-zsh = {
            enable = true;
            plugins = [ "git" ];
            theme = "robbyrussell";
        };
      };
    };
}
