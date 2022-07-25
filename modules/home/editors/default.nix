{ inputs, config, lib, pkgs, ... }: {
  imports = [
    ./emacs
    ./vim.nix
    ./vscode.nix
  ];
}
