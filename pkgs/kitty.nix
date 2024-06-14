_: {
  programs.kitty = {
    enable = true;
    shellIntegration.mode = "enabled";
    theme = "Catppuccin-Mocha";

    font = {
      name = "Maple Mono NF";
      size = 16;
    };

    keybindings."cmd+shift+enter" = "detach_window ask";

    extraConfig = ''
      modify_font   underline_position      5
    '';

    settings = {
      allow_remote_control = "socket-only";
      background_blur = 32;
      background_opacity = "0.85";
      editor = "nvim";
      hide_window_decorations = "titlebar-only";
      placement_strategy = "center";
      inactive_text_alpha = 1;
      scrollback_lines = 5000;
      wheel_scroll_multiplier = 5;
      touch_scroll_multiplier = 1;
      tab_bar_min_tabs = 2;
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{index} - {title}";
      cursor_shape = "beam";
      active_tab_font_style = "bold";
      inactive_tab_font_style = "normal";
      adjust_column_width = 0;
      macos_option_as_alt = "both";
    };
  };
}
