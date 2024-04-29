{
  inputs,
  pkgs,
  ...
}:
with pkgs; {
  imports = with inputs; [
    pkgs/fish.nix
    pkgs/kitty.nix
    modules/macchina.nix

    nix-index-database.hmModules.nix-index
  ];

  manual = {
    manpages.enable = false;
    html.enable = false;
    json.enable = false;
  };

  nix.registry = lib.mapAttrs (_: v: {flake = v;}) inputs;

  home = {
    packages =
      [
        alejandra
        cargo-edit
        cargo-udeps
        cmake
        duf
        eternal-terminal
        fend
        gcc
        gleam
        grc
        helix
        huniq
        hurl
        igrep
        keybase
        keychain
        monolith
        nix-output-monitor
        nix-prefetch-scripts
        nixd
        nodePackages_latest.nodejs
        nurl
        pinentry_mac
        pkg-config
        repgrep
        rm-improved
        rnr
        stylua
        tailspin
        tokei
        typst
        typst-live
        typstfmt
        unrar
        unzip
        upx
        vgrep
        wget
        xcp
        xh
      ]
      ++ (with inputs; [
        caligula.packages.${system}.default
        deadnix.packages.${system}.default
        nixvim-config.packages.${system}.default
      ])
      ++ (with darwin.apple_sdk.frameworks; [
        AppKit
        Carbon
        Cocoa
        CoreFoundation
        DisplayServices
        IOKit
        Security
        WebKit
      ]);

    stateVersion = "23.05";
  };

  programs = {
    bacon.enable = true;
    btop.enable = true;
    bun.enable = true;
    fd.enable = true;
    fzf.enable = true;
    git-cliff.enable = true;
    gpg.enable = true;
    nix-index-database.comma.enable = true;
    nix-index.enable = true;
    ripgrep.enable = true;
    skim.enable = true;
    tealdeer.enable = true;
    zoxide.enable = true;

    bat = {
      enable = true;
      config.theme = "catppuccin";

      themes.catppuccin = {
        src = fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
          hash = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
        };

        file = "/Catppuccin-mocha.tmTheme";
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    eza = {
      enable = true;
      extraOptions = ["--icons" "--header" "--group-directories-first"];
    };

    gh = {
      enable = false;
      settings.git_protocol = "ssh";

      extensions = [gh-eco gh-dash gh-markdown-preview];
    };

    git = {
      enable = true;
      package = gitAndTools.gitFull;
      userName = "pupbrained";
      userEmail = "mars@pupbrained.xyz";
      aliases."pushall" = "!git remote | xargs -L1 git push";
      difftastic.enable = true;

      extraConfig = {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
      };

      signing = {
        signByDefault = true;
        key = "874E22DF2F9DFCB5";
      };
    };

    go = {
      enable = true;

      packages = {
        "github.com/charmbracelet/bubbletea" =
          builtins.fetchGit "https://github.com/charmbracelet/bubbletea";
      };
    };

    java = {
      enable = true;
      package = jdk17;
    };

    jq = {
      enable = true;
      package = jql;
    };

    lazygit = {
      enable = true;

      settings.gui.theme = {
        lightTheme = false;
        activeBorderColor = ["#a6e3a1" "bold"];
        inactiveBorderColor = ["#cdd6f4"];
        optionsTextColor = ["#89b4fa"];
        selectedLineBgColor = ["#313244"];
        selectedRangeBgColor = ["#313244"];
        cherryPickedCommitBgColor = ["#94e2d5"];
        cherryPickedCommitFgColor = ["#89b4fa"];
        unstagedChangesColor = ["red"];
      };
    };

    macchina = {
      enable = true;

      config = {
        theme = "Mezora";
        show = [
          "Kernel"
          "Machine"
          "OperatingSystem"
          "Resolution"
          "Uptime"
          "LocalIP"
          "Packages"
          "ProcessorLoad"
          "Memory"
          "Battery"
        ];
      };

      themes = {
        Mezora = {
          separator = "";
          separator_color = "blue";
          key_color = "blue";

          palette = {
            type = "Dark";
            visible = true;
            glyph = " ⬤ ";
          };

          box = {
            border = "rounded";
            visible = true;
            inner_margin = {
              x = 0;
              y = 1;
            };
          };

          bar = {
            glyph = "○";
            hide_delimiters = true;
            visible = true;
          };

          keys = {
            host = "  Host";
            kernel = "  Kernel";
            packages = "  Packages";
            cpu_load = "  CPU";
            memory = "  Memory";
            battery = "  Battery";
            resolution = "  Res";
            uptime = "  Uptime";
            os = "  OS";
            machine = "  Machine";
          };
        };
      };
    };

    starship = {
      enable = true;
      settings = {
        jobs.disabled = true;
        palette = "catppuccin_mocha";
        nix_shell.symbol = "❄️  ";

        palettes.catppuccin_mocha = {
          rosewater = "#f5e0dc";
          flamingo = "#f2cdcd";
          pink = "#f5c2e7";
          mauve = "#cba6f7";
          red = "#f38ba8";
          maroon = "#eba0ac";
          peach = "#fab387";
          yellow = "#f9e2af";
          green = "#a6e3a1";
          teal = "#94e2d5";
          sky = "#89dceb";
          sapphire = "#74c7ec";
          blue = "#89b4fa";
          lavender = "#b4befe";
          text = "#cdd6f4";
          subtext1 = "#bac2de";
          subtext0 = "#a6adc8";
          overlay2 = "#9399b2";
          overlay1 = "#7f849c";
          overlay0 = "#6c7086";
          surface2 = "#585b70";
          surface1 = "#45475a";
          surface0 = "#313244";
          base = "#1e1e2e";
          mantle = "#181825";
          crust = "#11111b";
        };
      };
    };

    wezterm = {
      enable = true;
      extraConfig = ''
        local wezterm = require('wezterm')
        local c = wezterm.config_builder()

        function scheme_for_appearance(appearance)
          if appearance:find 'Dark' then
            return 'Catppuccin Mocha'
          else
            return 'Catppuccin Latte'
          end
        end

        wezterm.plugin.require('https://github.com/nekowinston/wezterm-bar').apply_to_config(c, {
          position = 'bottom',
          max_width = 32,
          dividers = 'slant_right',
          indicator = {
            leader = {
              enabled = true,
              off = ' ',
              on = ' ',
            },
            mode = {
              enabled = true,
              names = {
                resize_mode = 'RESIZE',
                copy_mode = 'VISUAL',
                search_mode = 'SEARCH',
              },
            },
          },
          tabs = {
            numerals = 'arabic',
            pane_count = 'subscript',
            brackets = {
              active = { "", ':' },
              inactive = { "", ':' },
            },
          },
          clock = {
            enabled = true,
            format = '%l:%M %p',
          },
        })

        local config = {
          font_size = 16,
          color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
          front_end = 'WebGpu',
          webgpu_power_preference = 'HighPerformance',
          window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
          enable_scroll_bar = false,
          use_fancy_tab_bar = false,
          window_background_opacity = 0.8,
          window_decorations = 'RESIZE',
          default_cursor_style = 'BlinkingBar',
          cursor_blink_rate = 500,
          cursor_blink_ease_in = 'Constant',
          cursor_blink_ease_out = 'Constant',
          font = wezterm.font_with_fallback {
            {
              family = 'Victor Mono',
              weight = 'Medium',
            },
          },
          adjust_window_size_when_changing_font_size = false
        }

        for k, v in pairs(config) do
          c[k] = v
        end

        return c
      '';
    };
  };
}
