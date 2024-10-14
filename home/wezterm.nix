{ pkgs, lib, config, ... }:

{
    options = {
        wezterm.enable = lib.mkEnableOption "enable wezterm";
        wezterm.mac = lib.mkOption {
            type = lib.types.bool;
            default = false;
        };
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
            config.enable_wayland = false
            ${if config.wezterm.mac then "config.front_end = \"WebGpu\"
config.send_composed_key_when_left_alt_is_pressed = true
config.keys = {
    -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
    {key=\"LeftArrow\", mods=\"OPT\", action=wezterm.action{SendString=\"\\x1bb\"}},
    -- Make Option-Right equivalent to Alt-f; forward-word
    {key=\"RightArrow\", mods=\"OPT\", action=wezterm.action{SendString=\"\\x1bf\"}},
}" else ""}

            return config
        '';
      };
    };
}
