{ pkgs, lib, config, ... }:

{
    options = {
        ohmyposh.enable = lib.mkEnableOption "enable ohmyposh";
    };

    config = lib.mkIf config.ohmyposh.enable {
      programs.oh-my-posh = {
            enable = true;
            enableZshIntegration = true;
            settings = {
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
                      "foreground" = "p:crystalBlue";
                    }
                    {
                      "type" = "git";
                      "style" = "plain";
                      "template" = " {{ .HEAD }}{{ if or (.Working.Changed) (.Staging.Changed) }}*{{ end }} <p:dragonBlue>{{ if gt .Behind 0 }}\u21e3{{ end }}{{ if gt .Ahead 0 }}\u21e1{{ end }}</>";
                      "properties" = {
                        "branch_icon" = "";
                        "commit_icon" = "@";
                        "fetch_status" = true;
                      };
                      "background" = "transparent";
                      "foreground" = "p:springGreen";
                    }
                    {
                      "type" = "python";
                      "style" = "plain";
                      "template" = "  {{ if .Error }}{{ .Error }}{{ else }}{{ if .Venv }}{{ .Venv }} {{ end }}{{ .Full }}{{ end }}";
                      "background" = "transparent";
                      "foreground" = "p:carpYellow";
                    }
                    {
                      "type" = "go";
                      "style" = "plain";
                      "template" = "  {{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}";
                      "background" = "transparent";
                      "foreground" = "p:dragonBlue";
                    }
                    {
                        "type" = "nix-shell";
                        "style" = "plain";
                        "background" = "transparent";
                        "foreground" = "p:oldWhite";
                        "template" = " {{ if matchP \".?pure\" .Type  }}via (nix-{{ .Env.NIXPROFILE }}){{ end }}";
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
                      "foreground" = "p:fujiWhite";
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
                        "{{if gt .Code 0}}p:samuraiRed{{end}}"
                        "{{if eq .Code 0}}p:white{{end}}"
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
                  "{{if gt .Code 0}}p:samuraiRed{{end}}"
                  "{{if eq .Code 0}}p:white{{end}}"
                ];
                "template" = "❯ ";
                "background" = "transparent";
              };
              "secondary_prompt" = {
                "template" = "❯❯ ";
                "background" = "transparent";
                "foreground" = "p:oldWhite";
              };
              "palette" = {
                "carpYellow" = "#E6C384";
                "crystalBlue" = "#7E9CD8";
                "dragonBlue" = "#658594";
                "fujiGray" = "#727169";
                "fujiWhite" = "#DCD7BA";
                "oldWhite" = "#C8C093";
                "samuraiRed" = "#E82424";
                "springGreen" = "#98BB6C";
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
            };
            };
    };
}
