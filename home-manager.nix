inputs @ {self, ...}: {
  config,
  pkgs,
  lib,
  ...
}:
with builtins; let
  std = pkgs.lib;
  emacs = config.programs.ashmacs;
in {
  options = with lib; {
    programs.ashmacs = {
      enable = mkEnableOption "Ash Walker's Emacs configuration";
      package = mkOption {
        type = types.package;
        default = pkgs.emacs;
      };
      settings = {
        enable = (mkEnableOption "install ashmacs configuration") // {default = config.system.isNixOS or true;};
      };
    };
  };
  disabledModules = [];
  imports = [];
  config = lib.mkIf emacs.enable (lib.mkMerge [
    {
      # home.packages = [emacs.package];
    }
    (lib.mkIf (config ? signal.dev.editor.editors) {
      signal.dev.editor.editors."emacs" = {
        cmd.term = "emacs";
      };
    })
    (lib.mkIf emacs.settings.enable {
      home.file.".emacs.d" = {
        source = toString self;
        recursive = false;
      };
    })
  ]);
  meta = {};
}
