{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.home.editors.vim;
in {
  options.modules.home.editors.vim = {
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
