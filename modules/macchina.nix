{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.programs.macchina;
  tomlFormat = pkgs.formats.toml {};
in {
  options.programs.macchina = {
    enable = mkEnableOption "macchina";
    package = mkPackageOption pkgs "macchina" {};

    config = mkOption {
      inherit (tomlFormat) type;
      default = {};

      example = {
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

      description = ''
        Macchina configuration.
      '';
    };

    themes = with types;
      mkOption {
        type = attrs;
        #type = attrsOf (submodule (_: {
        #options = {
        #spacing = mkNullable {
        #type = int;
        #example = 1;
        #description = ''
        #Defines the amount of spacing to leave between the separator and the content besides it.
        #'';
        #};

        #padding = mkNullable {
        #type = int;
        #example = 0;
        #description = ''
        #Defines the amount of padding to leave between the content and its surroundings.
        #'';
        #};

        #hide_ascii = mkNullable {
        #type = bool;
        #example = false;
        #description = ''
        #Disables the rendering of ASCII, whether it be built-in or custom.
        #'';
        #};

        #prefer_small_ascii = mkNullable {
        #type = bool;
        #example = true;
        #description = ''
        #For built-in ASCII, always use smaller variants.
        #'';
        #};

        #separator = mkNullable {
        #type = str;
        #example = "-->";
        #description = ''
        #Defines the glyph to use for the separator.
        #'';
        #};

        #key_color = mkNullable {
        #type = str;
        #example = "#00FF00";
        #description = ''
        #Defines the color of the keys.

        #Accepts hexadecimal values:
        #`color = "#00FF00"`

        #Indexed values:
        #`color = "046"`

        #Predefined color names, where casing is insensitive:
        #`color = "Green"`
        #'';
        #};

        #separator_color = mkNullable {
        #type = str;
        #example = "#00FF00";
        #description = ''
        #Defines the color of the separator.

        #Accepts hexadecimal values:
        #`color = "#00FF00"`

        #Indexed values:
        #`color = "046"`

        #Predefined color names, where casing is insensitive:
        #`color = "Green"`
        #'';
        #};

        #palette = mkNullable {
        #type = submodule {
        #options = {
        #type = mkNullable {
        #type = str;
        #example = "Dark";
        #description = ''
        #Defines the color set to use for the palette.
        #'';
        #};

        #glyph = mkNullable {
        #type = str;
        #example = "() ";
        #description = ''
        #Defines the glyph to use for the palette.

        #You should append a space to leave some room between the glyphs.
        #'';
        #};

        #visible = mkNullable {
        #type = bool;
        #example = true;
        #description = ''
        #Defines whether to show or hide the palette.
        #'';
        #};
        #};
        #};
        #};

        #box = mkNullable {
        #type = attrs;
        #};

        #bar = mkNullable {
        #type = attrs;
        #};

        #keys = mkNullable {
        #type = attrs;
        #};
        #};
        #}));
      };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];
    xdg.configFile =
      mkIf (cfg.config != {}) {
        "macchina/macchina.toml".source =
          tomlFormat.generate "macchina.toml" cfg.config;
      }
      // mkIf (cfg.themes != {}) (
        attrsets.concatMapAttrs (name: value: {
          "macchina/themes/${name}.toml".source =
            tomlFormat.generate "${name}.toml" value;
        })
        cfg.themes
      );
  };
}
