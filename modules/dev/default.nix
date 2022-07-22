{ inputs, config, lib, pkgs, ... }: {
  imports = [
    ./elixir.nix
    ./go.nix
    ./node.nix
    ./python.nix
    ./ruby.nix
    ./rust.nix
  ];
}
