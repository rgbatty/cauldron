{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.editors.vim;
in {
  options.modules.editors.vim = {
    enable = mkEnableOption "Vim";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      neovim
    ];

    home.shellAliases = {
      vim = "nvim";
      v = "nvim";
    };
  };
}
