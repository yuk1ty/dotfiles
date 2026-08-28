{
  inputs,
  username,
  ...
}: {
  imports = [
    inputs.home-manager.darwinModules.home-manager
    ./homebrew.nix
    ./system-defaults.nix
  ];

  # Determinate Nix が /etc/nix/nix.conf と nix daemon を管理しているため、
  # nix-darwin 側での Nix の管理は無効化する
  # (nix.* オプションは使用不可になるが、flakes 等の設定は Determinate 側で済んでいる)
  nix.enable = false;

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };

  # home-manager (useUserPackages) がホームディレクトリと
  # パッケージのインストール先を解決するために必要な宣言
  users.users.${username}.home = "/Users/${username}";

  system = {
    primaryUser = username;
    stateVersion = 7;
  };

  programs.zsh.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    # ../home から inputs (uv2nix 等) を参照できるようにする
    extraSpecialArgs = {inherit inputs;};
    users.${username} = import ../home/core.nix;
  };
}
