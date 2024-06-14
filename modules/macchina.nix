{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.programs.macchina;
  tomlFormat = pkgs.formats.toml {};
in {
  options.programs.macchina = {
    enable = lib.mkEnableOption "macchina";
    package = lib.mkPackageOption pkgs "macchina" {};

    config = lib.mkOption {
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

    themes = with lib.types;
      lib.mkOption {
        type = attrs;
      };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];
    xdg.configFile =
      {
        "macchina/macchina.toml".source =
          tomlFormat.generate "macchina.toml" cfg.config;
      }
      // (
        lib.attrsets.concatMapAttrs (name: value: {
          "macchina/themes/${name}.toml".source =
            tomlFormat.generate "${name}.toml" value;
        })
        cfg.themes
      );
  };
}
