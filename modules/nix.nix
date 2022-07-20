{ pkgs, ... }: {
  config = {
    home.packages = with pkgs; [
      git
      nix-diff
      nix-du
      nix-info
      nix-prefetch-git
      nix-tree
      nixfmt
      nixpkgs-fmt
      nixpkgs-review
    ] ++ pkgs.lib.optional (pkgs.stdenv.isLinux) pkgs.nix-serve;
  };
}
