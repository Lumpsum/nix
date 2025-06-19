{ pkgs, lib, config, ... }:

{
    options = {
        k9s.enable = lib.mkEnableOption "enable k9s";
    };

    config = lib.mkIf config.k9s.enable {
      programs.k9s = {
        enable = true;
        settings = {
            k9s = {
                liveViewAutoRefresh = "false";
                refreshRate = "2";
                maxConnRetry = "5";
                readOnly = "false";
                ui = {
                    enableMouse = "false";
                    headless = "false";
                    logoless = "false";
                    crumbsless = "false";
                    noIcons = "false";
                    # Toggles reactive UI. This option provide for watching on disk artifacts changes and update the UI live  Defaults to false.
                    reactive = "false";
                    # Uses in_the_navy skin located in your $XDG_CONFIG_HOME/skins/in_the_navy.yaml
                    # skin = "kanagawa";
                };
            };
        };
        skins = {
            kanagawa = {
                k9s = {
                  body = {
                    fgColor = "dcd7ba";
                    bgColor = "#1f1f28";
                    logoColor = "#76946ab";
                  };
                  prompt = {
                    fgColor = "dcd7ba";
                    bgColor = "#1f1f28";
                    suggestColor = "#ffa066";
                  };
                  info = {
                    fgColor = "#727169";
                    sectionColor = "#76946ab";
                  };
                  help = {
                    fgColor = "dcd7ba";
                    bgColor = "#1f1f28";
                    keyColor = "#c0a36e";
                    numKeyColor = "#7e9cd8";
                    sectionColor = "#ffa066";
                  };
                  dialog = {
                    fgColor = "#090618";
                    bgColor = "#1f1f28";
                    buttonFgColor = "dcd7ba";
                    buttonBgColor = "#76946ab";
                    buttonFocusFgColor = "#090618";
                    buttonFocusBgColor = "#7e9cd8";
                    labelFgColor = "#ffa066";
                    fieldFgColor = "#7e9cd8";
                  };
                  frame = {
                    border = {
                      fgColor = "#76946ab";
                      focusColor = "#76946ab";
                    };
                    menu = {
                      fgColor = "#727169";
                      keyColor = "#c0a36e";
                      numKeyColor = "#c0a36e";
                    };
                    crumbs = {
                      fgColor = "#090618";
                      bgColor = "#76946ab";
                      activeColor = "#c0a36e";
                    };
                    status = {
                      newColor = "#7e9cd8";
                      modifyColor = "#76946ab";
                      addColor = "#727169";
                      pendingColor = "#ffa066";
                      errorColor = "#c34043";
                      highlightColor = "#c0a36e";
                      killColor = "#ffa066";
                      completedColor = "#727169";
                    };
                    title = {
                      fgColor = "#7e9cd8";
                      bgColor = "#1f1f28";
                      highlightColor = "#ffa066";
                      counterColor = "dcd7ba";
                      filterColor = "#7e9cd8";
                    };
                  };
                  views = {
                    charts = {
                      bgColor = "#1f1f28";
                      defaultDialColors = [
                        "#76946ab"
                        "#c34043"
                        ];
                      defaultChartColors = [
                        "#76946ab"
                        "#c34043"
                        ];
                    };
                    table = {
                      fgColor = "#c0a36e";
                      bgColor = "#1f1f28";
                      cursorFgColor = "#090618";
                      cursorBgColor = "#7e9cd8";
                      markColor = "#e6c384";
                      header = {
                        fgColor = "#727169";
                        bgColor = "#1f1f28";
                        sorterColor = "#ffa066";
                      };
                    };
                    xray = {
                      fgColor = "#7e9cd8";
                      bgColor = "#1f1f28";
                      cursorColor = "dcd7ba";
                      graphicColor = "#e6c384";
                      showIcons = "false";
                    };
                    yaml = {
                      keyColor = "#c34043";
                      colonColor = "#727169";
                      valueColor = "#727169";
                    };
                    logs = {
                      fgColor = "#727169";
                      bgColor = "#1f1f28";
                      indicator = {
                        fgColor = "#7e9cd8";
                        bgColor = "#1f1f28";
                        toggleOnColor = "#c34043";
                        toggleOffColor = "#727169";
                      };
                    };
                    help = {
                      fgColor = "#727169";
                      bgColor = "#1f1f28";
                      indicator = {
                        fgColor = "#7e9cd8";
                      };
                    };
                  };
                };
            };
        };
      };
    };
}
