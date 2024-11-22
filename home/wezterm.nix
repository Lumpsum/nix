{ pkgs, lib, config, ... }:

{
    options = {
        wezterm.enable = lib.mkEnableOption "enable wezterm";
        wezterm.package = lib.mkOption {
            default = pkgs.wezterm;
        };
        wezterm.mac = lib.mkOption {
            type = lib.types.bool;
            default = false;
        };
        wezterm.theme = lib.mkOption {
            type = lib.types.str;
            default = "kanagawa";
        };
    };

    config = lib.mkIf config.wezterm.enable {
      programs.wezterm = {
        enable = true;
        enableZshIntegration = true;
        package = config.wezterm.package;
        extraConfig = ''
            local config = wezterm.config_builder()

            config.font_size = 16.0
            config.hide_tab_bar_if_only_one_tab = true
            config.default_prog = { "zsh", "--login", "-c", "tmux attach -t dev || tmux new -s dev" }
            config.enable_wayland = false
            config.color_scheme = "${if config.wezterm.theme == "monoglow" then "monoglow" else "kanagawa"}"
            config.window_padding = {
                left = 0,
                right = 0,
                top = 0,
                bottom = 0,
            }
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
        colorSchemes = {
            kanagawa = {
                foreground = "#dcd7ba";
                background = "#1f1f28";

                cursor_bg = "#c8c093";
                cursor_fg = "#c8c093";
                cursor_border = "#c8c093";

                selection_fg = "#c8c093";
                selection_bg = "#2d4f67";

                scrollbar_thumb = "#16161d";
                split = "#16161d";

                ansi = [ "#090618" "#c34043" "#76946a" "#c0a36e" "#7e9cd8" "#957fb8" "#6a9589" "#c8c093" ];
                brights = [ "#727169" "#e82424" "#98bb6c" "#e6c384" "#7fb4ca" "#938aa9" "#7aa89f" "#dcd7ba" ];
            };
            monoglow = {
                foreground = "#cccccc";
                background = "#121212";

                cursor_bg = "#c8c093";
                cursor_fg = "#c8c093";
                cursor_border = "#c8c093";

                selection_fg = "#555555";
                selection_bg = "#2a2a2a";

                scrollbar_thumb = "#16161d";
                split = "#16161d";
                # brights = [ "#444444" "#555555" "#7a7a7a" "#aaaaaa" "#cccccc" "#dddddd" "1f1f1f1" "#1bfd9c" ];
                ansi = [ "2a2a2a" "#444444" "#1bfd9c" "#555555" "7a7a7a" "#aaaaaa" "#cccccc" "#dddddd" ];
                brights = [ "2a2a2a" "#444444" "#1bfd9c" "#555555" "7a7a7a" "#aaaaaa" "#cccccc" "#dddddd" ];
            };
        };
      };
    };
}
