{ inputs, lib, config, flake, pkgs, home-manager, ... }: {
  imports = [  ];

  services.nix-daemon.enable = true;
  nix.package = pkgs.nixFlakes;
  nix.trustedUsers = [ "@admin" "@staff" ];
  nix.extraOptions = ''
    auto-optimise-store = false
    builders-use-substitutes = true
    experimental-features = nix-command flakes
    keep-derivations = true
    keep-outputs = true
  '';

  system.stateVersion = 4;
}
