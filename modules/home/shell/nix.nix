# TODO: Nix configuration
# * aliasing

{ pkgs, ... }: {
  config = {
    home.packages = with pkgs; [
      git
      manix
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

  # nix aliases
    # n = "nix";
    # np = "n profile";
    # ni = "np install";
    # nr = "np remove";
    # ns = "n search --no-update-lock-file";
    # nf = "n flake";
    # nepl = "n repl '<nixpkgs>'";
    # srch = "ns nixos";
    # orch = "ns override";
    # mn = ''
    #   manix "" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^ //' | sk --preview="manix '{}'" | xargs manix
    # '';
}
