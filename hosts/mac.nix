{ ... }:
{
  system.primaryUser = "petezalewski";
  system.stateVersion = 6;

  users.users.petezalewski.home = "/Users/petezalewski";

  security.pam.services.sudo_local.touchIdAuth = true;

  # DSI manages Nix itself — keep nix-darwin out of /etc/nix/nix.conf.
  nix.enable = false;
}
