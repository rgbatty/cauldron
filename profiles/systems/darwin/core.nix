{ inputs, lib, config, flake, pkgs, home-manager, ... }:
let
  mapUsersToAttrs = users: fn: builtins.listToAttrs (
    map (user: { name = user; value = fn(user); }) users
  );
in {
  imports = [  ];

  environment.shells = with pkgs; [ bashInteractive fish zsh ];

  users.users = mapUsersToAttrs inputs.users (user: {
    name = user;
    shell = pkgs.fish;
  });

  home-manager.users = mapUsersToAttrs inputs.users (user: {
    imports = [
      ../../../modules
      ../../../profiles/users/${user}
    ];
  });

  services.nix-daemon.enable = true;
}
