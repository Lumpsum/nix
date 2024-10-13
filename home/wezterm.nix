{ pkgs, lib, config, ... }:

{
    options = {
        wezterm.enable = lib.mkEnableOption "enable wezterm";
    };

    config = lib.mkIf config.wezterm.enable {
      programs.wezterm = {
        enable = true;
        enableZshIntegration = true;
        extraConfig = ''
            local config = wezterm.config_builder()

            config.font_size = 16.0
            config.hide_tab_bar_if_only_one_tab = true
            config.default_prog = { "zsh", "--login", "-c", "tmux attach -t dev || tmux new -s dev" }
            config.enable_wayland = true

            return config
        '';
      };
    };
}
