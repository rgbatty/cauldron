{ hmUsers, ... }:
{
  home-manager.users = { inherit (hmUsers) rbatty; };

  users.users.rbatty = {
    description = "default";
  };
}
