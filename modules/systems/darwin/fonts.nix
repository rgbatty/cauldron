{ inputs, config, lib, pkgs, ... }: {
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      fira-code
      fira-code-symbols
      fira-mono
      (nerdfonts.override {
      fonts =
        [ "FiraCode" "FiraMono" ];
    })
    ];
  };
}
