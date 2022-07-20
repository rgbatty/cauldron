{ inputs, lib, config, flake, pkgs, home-manager, ... }: {
  imports = [
    ../../core.nix
  ];

  environment.shells = with pkgs; [ bashInteractive fish zsh ];

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

  programs.fish.enable = true;
}

