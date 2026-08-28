{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./packages.nix
    ./session-variables.nix
  ];

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
