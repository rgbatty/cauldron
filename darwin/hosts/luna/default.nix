{ config, pkgs, ... }: {
  imports = [ ../../profiles/base ];

  users.users.rbatty = { name = "rbatty"; };
}
