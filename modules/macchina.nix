{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.programs.macchina;
  settingsFormat = pkgs.formats.toml {};
in {
  options.programs.macchina = {
    enable = mkEnableOption "Enable Macchina";
    package = mkPackageOption pkgs "macchina" {};
    config = mkOption {
      type = with types; attrsOf (oneOf [str (listOf str) bool]);
      default = {};
      example = {
        theme = "Helium";
        show = ["Kernel" "Machine" "OperatingSystem"];
      };
      description = ''
        Macchina configuration.
      '';
    };
    themes = mkOption {
      type = with types; listOf (attrsOf (oneOf [str (listOf str) bool]));
      default = {};
      example = [
        {
          name = "Mezora";
          separator = "";
          separator_color = "blue";
          key_color = "blue";

          palette = {
            type = "Dark";
          };
        }
      ];
      description = ''
        Macchina configuration.
      '';
    };
  };

  config = let
    themes = builtins.forEach (theme: "${theme.name}.toml") (theme: {
      "macchina/${theme.name}.toml".source =
        settingsFormat.generate
        "${theme.name}.toml"
        theme;
    });
  in
    mkIf cfg.enable {
      home.packages = [cfg.package];
      xdg.configFile = {
        inherit themes;
        "macchina/macchina.toml".source =
          mkIf cfg.config
          settingsFormat.generate "macchina.toml"
          cfg.config;
      };
    };
}
