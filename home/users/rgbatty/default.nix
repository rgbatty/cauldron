{ hmUsers, ... }:
{
  home-manager.users = { inherit (hmUsers) rgbatty; };

  users.users.rgbatty = {
    description = "default";
  };
}
