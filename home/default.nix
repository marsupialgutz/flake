{
  inputs,
  pkgs,
  config,
  spicetify-nix,
  hyprland-contrib,
  xdg-hyprland,
  ...
}:
with pkgs; {
  imports = [
    ./dotfiles.nix
    ../pkgs/nixvim.nix
    ../pkgs/nushell.nix
    inputs.spicetify-nix.homeManagerModule
    inputs.hyprland.homeManagerModules.default
    inputs.nur.nixosModules.nur
    inputs.nixvim.homeManagerModules.nixvim
  ];

  home = {
    file.".mozilla/firefox/marshall/chrome" = {
      source = ../dotfiles/firefox;
      recursive = true;
    };

    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.catppuccin-cursors;
      name = "Catppuccin-Mocha-Dark-Cursors";
      size = 24;
    };

    packages =
      [
        # SNOW BEGIN
        acpi
        alejandra
        audacity
        authy
        bacon
        binutils
        brightnessctl
        btop
        cachix
        carapace
        cargo-edit
        cargo-udeps
        cava
        cmake
        comma
        cozette
        curlie
        discord-plugged
        draconis
        edgedb
        file
        gcc
        gh
        gitoxide
        gleam
        glib
        glrnvim
        gnumake
        gopls
        gpick
        gradience
        grex
        grim
        gsettings-desktop-schemas
        headsetcontrol
        httpie-desktop
        hyprland-contrib.packages.${pkgs.system}.grimblast
        hyprpaper
        inotify-tools
        insomnia
        jamesdsp
        jetbrains-fleet
        jq
        keybase
        keychain
        kotatogram-desktop
        lazygit
        libappindicator
        libffi
        libgda6
        libnotify
        lucky-commit
        lxappearance
        micro
        minecraft
        mold
        mullvad-vpn
        mysql
        neovide
        ngrok
        nix-prefetch-scripts
        nix-snow
        nodejs-16_x
        notion-app-enhanced
        nurl
        obsidian
        odin
        openal
        p7zip
        pavucontrol
        playerctl
        prismlauncher
        pscale
        pulseaudio
        python
        python310
        revolt
        riff
        rnix-lsp
        rofi-wayland
        rust-analyzer-nightly
        rustup
        sapling
        scrot
        slurp
        starfetch
        starship
        statix
        stylua
        sumneko-lua-language-server
        swaynotificationcenter
        tealdeer
        tre
        unrar
        unzip
        waybar
        wf-recorder
        wget
        wineWowPackages.waylandFull
        wl-clipboard
        wl-color-picker
        xclip
        xdg-hyprland.packages.${pkgs.system}.hyprland-share-picker
        yarn
        zls
        zscroll
        # SNOW END
      ]
      ++ (with gnome; [
        dconf-editor
        eog
        file-roller
        gnome-tweaks
        nautilus
        seahorse
        zenity
      ])
      ++ (with gnomeExtensions; [
        arcmenu
        blur-my-shell
        browser-tabs
        burn-my-windows
        emoji-selector
        gnome-40-ui-improvements
        just-perfection
        mpris-label
        openweather
        pano
        pop-shell
        rounded-window-corners
        simply-workspaces
        tray-icons-reloaded
        vitals
      ])
      ++ (with nodePackages_latest; [
        eslint
        generator-code
        pnpm
        prettier
        typescript
        typescript-language-server
      ]);

    sessionVariables = {
      CLUTTER_BACKEND = "wayland";
      DEFAULT_BROWSER = "${pkgs.firefox-nightly-bin}/bin/firefox";
      DIRENV_LOG_FORMAT = "";
      DISABLE_QT5_COMPAT = "0";
      GBM_BACKEND = "nvidia-drm";
      GDK_BACKEND = "wayland";
      GDK_SCALE = "2";
      GLFW_IM_MODULE = "ibus";
      GPG_TTY = "$TTY";
      HOME_MANAGER_BACKUP_EXT = "bkp";
      LIBSEAT_BACKEND = "logind";
      LIBVA_DRIVER_NAME = "nvidia";
      NIXOS_OZONE_WL = "1";
      NIXPKGS_ALLOW_UNFREE = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SDL_VIDEODRIVER = "wayland";
      WLR_BACKEND = "vulkan";
      WLR_DRM_NO_ATOMIC = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
      WLR_RENDERER = "vulkan";
      XCURSOR_SIZE = "48";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      __GL_GSYNC_ALLOWED = "0";
      __GL_VRR_ALLOWED = "0";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };

  programs = with pkgs; {
    direnv.enable = true;
    gpg.enable = true;

    bat = {
      enable = true;
      config.theme = "catppuccin";

      themes = {
        catppuccin = builtins.readFile (fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "sublime-text";
            rev = "0b7ac201ce4ec7bac5e0063b9a7483ca99907bbf";
            sha256 = "1kn5v8g87r6pjzzij9p8j7z9afc6fj0n8drd24qyin8p1nrlifi1";
          }
          + "/Catppuccin.tmTheme");
      };
    };

    exa = {
      enable = true;
      enableAliases = true;
    };

    firefox = {
      enable = true;
      package = firefox-nightly-bin.override {
        cfg = {
          enableGnomeExtensions = true;
        };
      };

      extensions = with config.nur.repos.rycee.firefox-addons; [
        add-custom-search-engine
        darkreader
        don-t-fuck-with-paste
        https-everywhere
        new-tab-override
        protondb-for-steam
        react-devtools
        return-youtube-dislikes
        sponsorblock
        to-deepl
        ublock-origin
        unpaywall
        vimium
        violentmonkey
        firefox-addons.absolute-enable-right-click
        firefox-addons.active-forks
        firefox-addons.betterviewer
        firefox-addons.buster-captcha-solver
        firefox-addons.catppuccin-mocha-sky
        firefox-addons.clearurls
        firefox-addons.disconnect
        firefox-addons.docsafterdark
        firefox-addons.hyperchat
        firefox-addons.istilldontcareaboutcookies
        firefox-addons.mpris-integration
        firefox-addons.pinunpin-tab
        firefox-addons.pronoundb
        firefox-addons.svg-export
        firefox-addons.ttv-lol
        firefox-addons.twitch-points-autoclicker
        firefox-addons.webnowplaying-companion
        firefox-addons.youtube-addon
      ];

      profiles = {
        marshall = {
          settings = {
            "general.smoothScroll.currentVelocityWeighting" = "0.15";
            "general.smoothScroll.mouseWheel.durationMaxMS" = 250;
            "general.smoothScroll.mouseWheel.durationMinMS" = 250;
            "general.smoothScroll.msdPhysics.enabled" = true;
            "general.smoothScroll.msdPhysics.motionBeginSpringConstant" = 400;
            "general.smoothScroll.msdPhysics.regularSpringConstant" = 600;
            "general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = 120;
            "general.smoothScroll.other.durationMaxMS" = 500;
            "general.smoothScroll.pages.durationMaxMS" = 350;
            "general.smoothScroll.stopDecelerationWeighting" = "0.8";
            "gfx.webrender.all" = true;
            "svg.context-properties.content.enabled" = true;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "userChrome.FilledMenuIcons-Enabled" = true;
            "userChrome.OneLine-Enabled" = true;
            "userChrome.ProtonTabs-Enabled" = true;
          };
        };
      };
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = "pupbrained";
      userEmail = "mars@pupbrained.xyz";
      delta.enable = true;

      signing = {
        signByDefault = true;
        key = "DB41891AE0A1ED4D";
      };

      aliases = {
        "pushall" = "!git remote | xargs -L1 git push";
      };

      extraConfig = {
        push.autoSetupRemote = true;
      };
    };

    go = {
      enable = true;
      package = pkgs.go_1_19;
    };

    helix = {
      enable = true;
      settings = {
        theme = "catppuccin_mocha";
        editor = {
          line-number = "relative";
          cursorline = true;
          color-modes = true;
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          indent-guides.render = true;
        };
      };
    };

    java = {
      enable = true;
      package = pkgs.jdk;
    };

    kitty = {
      enable = true;

      font = {
        name = "Maple Mono NF";
        size = 14;
      };

      settings = {
        editor = "nvim";
        shell_integration = true;
        confirm_os_window_close = 0;
        allow_remote_control = "socket-only";
        listen_on = "unix:/tmp/kitty";
        placement_strategy = "center";
        hide_window_decorations = "yes";
        background_opacity = "0.8";
        dynamic_background_opacity = true;
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
        foreground = "#CDD6F4";
        background = "#1E1E2E";
        selection_foreground = "#1E1E2E";
        selection_background = "#F5E0DC";
        cursor = "#F5E0DC";
        cursor_text_color = "#1E1E2E";
        url_color = "#B4BEFE";
        active_border_color = "#CBA6F7";
        inactive_border_color = "#8E95B3";
        bell_border_color = "#EBA0AC";
        active_tab_foreground = "#11111B";
        active_tab_background = "#CBA6F7";
        inactive_tab_foreground = "#CDD6F4";
        inactive_tab_background = "#181825";
        tab_bar_background = "#11111B";
        mark1_foreground = "#1E1E2E";
        mark1_background = "#87B0F9";
        mark2_foreground = "#1E1E2E";
        mark2_background = "#CBA6F7";
        mark3_foreground = "#1E1E2E";
        mark3_background = "#74C7EC";
        color0 = "#45475A";
        color1 = "#F38BA8";
        color2 = "#A6E3A1";
        color3 = "#F9E2AF";
        color4 = "#89B4FA";
        color5 = "#F5C2E7";
        color6 = "#94E2D5";
        color7 = "#BAC2DE";
        color8 = "#45475A";
        color9 = "#F38BA8";
        color10 = "#A6E3A1";
        color11 = "#F9E2AF";
        color12 = "#89B4FA";
        color13 = "#F5C2E7";
        color14 = "#94E2D5";
        color15 = "#BAC2DE";
      };
    };

    mpv = {
      enable = true;

      scripts = [
        mpvScripts.mpris
      ];
    };

    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };

    spicetify = let
      spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
    in {
      enable = true;
      theme = spicePkgs.themes.catppuccin-mocha;
      colorScheme = "sky";

      spotifyPackage = pkgs.spotify-unwrapped.overrideAttrs (o: {
        installPhase = o.installPhase + "wrapProgram $out/bin/spotify --prefix LD_PRELOAD : \"${pkgs.spotifywm-fixed}/lib/spotifywm.so\"";
      });

      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplayMod
        shuffle
        hidePodcasts
        playNext
        volumePercentage
        genre
        history
        lastfm
        copyToClipboard
        showQueueDuration
        songStats
        fullAlbumDate
        keyboardShortcut
        powerBar
        playlistIcons
      ];
    };

    vscode = {
      enable = true;

      userSettings = {
        breadcrumbs.enabled = false;
        emmet.useInlineCompletions = true;
        github.copilot.enable."*" = true;
        javascript.updateImportsOnFileMove.enabled = "always";
        scss.lint.unknownAtRules = "ignore";
        security.workspace.trust.untrustedFiles = "open";
        update.mode = "none";

        "[css]".editor.defaultFormatter = "esbenp.prettier-vscode";
        "[html]".editor.defaultFormatter = "esbenp.prettier-vscode";
        "[javascript]".editor.defaultFormatter = "rvest.vs-code-prettier-eslint";
        "[json]".editor.defaultFormatter = "esbenp.prettier-vscode";
        "[jsonc]".editor.defaultFormatter = "rvest.vs-code-prettier-eslint";
        "[nix]".editor.defaultFormatter = "kamadorueda.alejandra";
        "[rust]".editor.defaultFormatter = "rust-lang.rust-analyzer";
        "[scss]".editor.defaultFormatter = "sibiraj-s.vscode-scss-formatter";
        "[typescript]".editor.defaultFormatter = "rvest.vs-code-prettier-eslint";
        "[typescriptreact]".eslint.validate = [
          "javascript"
          "javascriptreact"
          "typescript"
          "typescriptreact"
        ];

        editor = {
          cursorBlinking = "smooth";
          cursorSmoothCaretAnimation = "on";
          cursorWidth = 2;
          defaultFormatter = "rvest.vs-code-prettier-eslint";
          find.addExtraSpaceOnTop = false;
          fontFamily = "'Maple Mono NF'";
          fontLigatures = true;
          fontSize = 16;
          formatOnSave = true;
          guides.bracketPairs = true;
          inlayHints.enabled = "off";
          inlineSuggest.enabled = true;
          largeFileOptimizations = false;
          lineNumbers = "on";
          linkedEditing = true;
          maxTokenizationLineLength = 60000;
          minimap.enabled = false;
          quickSuggestions.strings = true;
          renderWhitespace = "all";
          smoothScrolling = true;
          suggest.showStatusBar = true;
          suggestSelection = "first";

          bracketPairColorization = {
            enabled = true;
            independentColorPoolPerBracketType = true;
          };

          codeActionsOnSave.source = {
            organizeImports = true;
            fixAll.eslint = true;
          };

          unicodeHighlight.allowedCharacters = {
            "️" = true;
            "〇" = true;
            "’" = true;
          };
        };

        eslint = {
          format.enable = true;
          lintTask.enable = true;
          useESLintClass = true;
        };

        explorer = {
          confirmDragAndDrop = false;
          confirmDelete = true;
        };

        files = {
          autoSave = "afterDelay";
          eol = "\n";
          insertFinalNewline = true;

          exclude = {
            "**/.classpath" = true;
            "**/.direnv" = true;
            "**/.factorypath" = true;
            "**/.git" = true;
            "**/.project" = true;
            "**/.settings" = true;
          };
        };

        git = {
          autofetch = true;
          confirmSync = false;
          enableSmartCommit = true;
        };

        rust-analyzer = {
          procMacro.enable = false;
          signatureInfo.documentation.enable = false;

          rustfmt.extraArgs = [
            "--config [tab_spaces=2]"
          ];
        };

        terminal.integrated = {
          cursorBlinking = true;
          cursorStyle = "line";
          cursorWidth = 2;
          fontFamily = "'Maple Mono NF'";
          fontSize = 16;
          smoothScrolling = true;

          ignoreProcessNames = [
            "starship"
            "bash"
            "zsh"
            "fish"
            "nu"
          ];
        };

        vim = {
          enableNeovim = true;
          neovimConfigPath = "~/.config/nvim/init.lua";
          neovimPath = "/home/marshall/.nix-profile/bin/nvim";
          neovimUseConfigFile = true;

          cursorStylePerMode = {
            normal = "block";
            insert = "line";
            replace = "underline";
            visual = "block-outline";
            visualblock = "block-outline";
            visualline = "block-outline";
          };
        };

        window = {
          titleBarStyle = "custom";
          zoomLevel = 1;
        };

        workbench = {
          colorTheme = "Catppuccin Mocha";
          iconTheme = "material-icon-theme";
          smoothScrolling = true;
        };
      };

      package = vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions;
          [
            arrterian.nix-env-selector
            bbenoist.nix
            catppuccin.catppuccin-vsc
            dbaeumer.vscode-eslint
            esbenp.prettier-vscode
            github.copilot
            kamadorueda.alejandra
            matklad.rust-analyzer
            ms-vscode-remote.remote-ssh
            pkief.material-product-icons
            pkief.material-icon-theme
            vscodevim.vim
          ]
          ++ vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "feather-vscode";
              publisher = "melishev";
              version = "1.0.1";
              sha256 = "sha256-sFgNgNAFlTfx6m+Rp5lQxWnjSe7LLzB6N/gq7jQhRJs=";
            }
            {
              name = "vs-code-prettier-eslint";
              publisher = "rvest";
              version = "5.0.4";
              sha256 = "sha256-aLEAuFQQTxyFSfr7dXaYpm11UyBuDwBNa0SBCMJAVRI=";
            }
          ];
        vscode =
          (vscode.override {
            isInsiders = true;
          })
          .overrideAttrs
          (_: {
            src = builtins.fetchTarball {
              url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
              sha256 = "0za3yinia60spbmn1xsmp64lq0c6hyyhbyq42hxhdc0j54pbchfz";
            };
            version = "latest";
          });
      };
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = ["--cmd" "cd"];
    };
  };

  services = {
    kbfs.enable = true;
    keybase.enable = true;
    mpris-proxy.enable = true;

    gpg-agent = {
      enable = true;
      enableFishIntegration = true;
      pinentryFlavor = "gnome3";
    };
  };

  xdg = {
    mimeApps = {
      enable = true;

      defaultApplications = {
        "application/x-ms-dos-executable" = "wine.desktop";
        "inode/directory" = "org.gnome.Nautilus.desktop";
        "image/png" = "gnome.org.eog.desktop";
        "image/jpeg" = "gnome.org.eog.desktop";
        "image/gif" = "gnome.org.eog.desktop";
        "image/webp" = "gnome.org.eog.desktop";
        "text/html" = "firefox.desktop";
        "text/plain" = "nvim.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/pie" = "httpie.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
        "x-scheme-handler/vscode-insiders" = "code-insiders.desktop";
        "x-www-browser" = "firefox.desktop";
        "video/mp4" = "mpv.desktop";
        "video/webm" = "mpv.desktop";
        "video/H264" = "mpv.desktop";
      };
    };
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.catppuccin-gtk.override {
        tweaks = ["normal"];
        accents = ["mauve"];
        variant = "mocha";
      };
      name = "Catppuccin-Mocha-Standard-Mauve-Dark";
    };

    iconTheme = {
      package = pkgs.catppuccin-folders;
      name = "Papirus";
    };

    font = {
      name = "Google Sans Text";
      size = 11;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gnome";

    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita-dark";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    nvidiaPatches = true;
    systemdIntegration = true;
  };

  systemd.user.services.polkit = {
    Unit = {
      Description = "A dbus session bus service that is used to bring up authentication dialogs";
      Documentation = ["man:polkit(8)"];
      PartOf = ["graphical-session.target"];
    };
    Service = {
      Type = "simple";
      ExecStart = "${polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      RestartSec = 5;
      Restart = "always";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
