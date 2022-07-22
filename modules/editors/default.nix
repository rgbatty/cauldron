{ inputs, config, lib, pkgs, ... }: {
  imports = [
    ./emacs.nix
    ./vim.nix
    ./vscode.nix
  ];
}
