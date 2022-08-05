# TODO: Configure Dev Support
# * Add elixir
# * Add go
# * Add node
# * Add python
# * Add ruby
# * Add rust

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
