# TODO: Editor Configuration
# * Implement configurable global EDITOR env var for launching editors
# * Implement global launch alias (eg. 'e', 'edit')

{ inputs, config, lib, pkgs, ... }: {
  imports = [
    ./code
    ./emacs
    ./vim.nix
  ];
}
