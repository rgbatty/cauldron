{ config, pkgs, homePrefix, ... }:
{
  imports = [ ../common.nix ];
  modules = {
    editors.vscode.enable = true;
  };
}
