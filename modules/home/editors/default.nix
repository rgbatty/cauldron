# TODO: Editor Configuration
# * Implement configurable global EDITOR env var for launching editors
# * Implement global launch alias (eg. 'e', 'edit')

{ inputs, config, lib, pkgs, ... }: {
  imports = [
    ./emacs
    ./vim.nix
    ./vscode.nix
  ];
}
