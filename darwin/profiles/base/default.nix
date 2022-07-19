{ inputs, lib, config, flake, pkgs, home-manager, ... }:
let
  mapUsersToAttrs = users: fn: builtins.listToAttrs (
    map (user: { name = user; value = fn(user); }) users
  );
in {
  imports = [  ];

  users.users = mapUsersToAttrs inputs.users (user: {
    name = user;
  });

  home-manager.users = mapUsersToAttrs inputs.users (user: {
    imports = [
      ../../../modules
      ../../../profiles/users/${user}
    ];
  });

  services.nix-daemon.enable = true;
}
