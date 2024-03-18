{}:
final: prev: {
  unstable = pkgs;
  my = self.packages."${system}";
}
