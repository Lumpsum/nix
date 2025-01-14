{ pkgs, lib, config, ... }:

{
    options = {
        ohmyposh.enable = lib.mkEnableOption "enable ohmyposh";
        ohmyposh.theme = lib.mkOption {
            type = lib.types.str;
            default = "kanagawa";
        };
    };

    config = lib.mkIf config.ohmyposh.enable {
      programs.oh-my-posh = {
            enable = true;
            enableZshIntegration = true;
            settings = let
                theme = if config.ohmyposh.theme == "monoglow" then 
                    {
                        "path" = "#cccccc";
                        "git" = "#aaaaaa";
                        "python" = "#7a7a7a";
                        "go" = "#7a7a7a";
                        "nix" = "#555555";
                        "executiontime" = "#cccccc";
                        "exitcode1" = "#ffb3ba";
                        "exitcode0" = "#cccccc";
                        "secondary" = "#cccccc";
                    } 
                else
                    { 
                        "python" = "#E6C384";
                        "path" = "#7E9CD8";
                        "git" = "#98BB6C";
                        "go" = "#658594";
                        "nix" = "#C8C093";
                        "executiontime" = "#DCD7BA";
                        "exitcode1" = "#E82424";
                        "exitcode0" = "#ffffff";
                        "secondary" = "#C8C093";

                        "fujiGray" = "#727169";
                        "sumiInk0" = "#16161D";
                        "sumiInk1" = "#181820";
                        "sumiInk2" = "#1a1a22";
                        "sumiInk3" = "#1F1F28";
                        "sumiInk4" = "#2A2A37";
                        "sumiInk5" = "#363646";
                        "sumiInk6" = "#54546D";
                        "waveBlue1" = "#223249";
                        "waveBlue2" = "#2D4F67";
                    };
            in
            {
              "$schema" = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";
              "version" = 2;
              "final_space" = true;
              "console_title_template" = "{{ .Shell }} in {{ .Folder }}";
              "blocks" = [
                {
                  "type" = "prompt";
                  "alignment" = "left";
                  "segments" = [
                    {
                      "type" = "path";
                      "style" = "plain";
                      "template" = "{{ .Path }}";
                      "properties" = {
                        "style" = "full";
                      };
                      "background" = "transparent";
                      "foreground" = "p:path";
                    }
                    {
                      "type" = "git";
                      "style" = "plain";
                      "template" = " {{ .HEAD }}{{ if or (.Working.Changed) (.Staging.Changed) }}*{{ end }}<p:dragonBlue>{{ if gt .Behind 0 }}\u21e3{{ end }}{{ if gt .Ahead 0 }}\u21e1{{ end }}</>";
                      "properties" = {
                        "branch_icon" = "";
                        "commit_icon" = "@";
                        "fetch_status" = true;
                      };
                      "background" = "transparent";
                      "foreground" = "p:git";
                    }
                    {
                      "type" = "python";
                      "style" = "plain";
                      "template" = "  {{ if .Error }}{{ .Error }}{{ else }}{{ if .Venv }}{{ .Venv }} {{ end }}{{ .Full }}{{ end }}";
                      "background" = "transparent";
                      "foreground" = "p:python";
                    }
                    {
                      "type" = "go";
                      "style" = "plain";
                      "template" = "  {{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}";
                      "background" = "transparent";
                      "foreground" = "p:go";
                    }
                    {
                        "type" = "nix-shell";
                        "style" = "plain";
                        "background" = "transparent";
                        "foreground" = "p:nix";
                        "template" = " {{ if matchP \".?pure\" .Type  }}via (nix{{if .Env.NIXPROFILE }}-{{.Env.NIXPROFILE}}{{end}}){{ end }}";
                    }
                  ];
                  "newline" = true;
                }
                {
                  "type" = "rprompt";
                  "segments" = [
                    {
                      "type" = "executiontime";
                      "style" = "plain";
                      "template" = "{{ .FormattedMs }}";
                      "properties" = {
                        "threshold" = 5000;
                      };
                      "background" = "transparent";
                      "foreground" = "p:executiontime";
                    }
                  ];
                  "overflow" = "hidden";
                }
                {
                  "type" = "prompt";
                  "alignment" = "left";
                  "segments" = [
                    {
                      "type" = "text";
                      "style" = "plain";
                      "foreground_templates" = [
                        "{{if gt .Code 0}}p:exitcode1{{end}}"
                        "{{if eq .Code 0}}p:exitcode0{{end}}"
                      ];
                      "template" = "❯";
                      "background" = "transparent";
                    }
                  ];
                  "newline" = true;
                }
              ];
              "transient_prompt" = {
                "foreground_templates" = [
                    "{{if gt .Code 0}}p:exitcode1{{end}}"
                    "{{if eq .Code 0}}p:exitcode0{{end}}"
                ];
                "template" = "❯ ";
                "background" = "transparent";
              };
              "secondary_prompt" = {
                "template" = "❯❯ ";
                "background" = "transparent";
                "foreground" = "p:secondary";
              };
              "palette" = theme;
            };
            };
    };
}
