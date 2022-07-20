{ inputs, lib, config, flake, pkgs, home-manager, ... }: {
  imports = [
    ../../core.nix
  ];



  users.users.rbatty = {
    home = "/Users/rbatty";
    shell = pkgs.fish;
  };

  home-manager.users.rbatty = {
    imports = [
      ../../../../../modules
      ../../../../../profiles/users/rbatty
    ];
  };


}

