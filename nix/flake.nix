{
  description = "helloyuki's macOS configuration (nix-darwin + home-manager)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pyproject-nix = {
      url = "github:pyproject-nix/pyproject.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    uv2nix = {
      url = "github:pyproject-nix/uv2nix";
      inputs.pyproject-nix.follows = "pyproject-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pyproject-build-systems = {
      url = "github:pyproject-nix/build-system-pkgs";
      inputs.pyproject-nix.follows = "pyproject-nix";
      inputs.uv2nix.follows = "uv2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs @ {
      self,
      nix-darwin,
      nixpkgs,
      ...
    }: let
      # 共通モジュール (./darwin) を使うマシン定義のファクトリ。
      # 差分が出てきたら modules に per-host のファイルを足す
      mkMac = username:
        nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {inherit inputs username;};
          modules = [./darwin/core.nix];
        };
    in {
      darwinConfigurations.work = mkMac "toyoda";

      darwinConfigurations.private = mkMac "helloyuki";

      # 自前ビルドパッケージ (nix/packages/) のスタンドアロン検証用: nix build .#<name>
      packages.aarch64-darwin.headroom =
        (import nixpkgs {
          system = "aarch64-darwin";
          config.allowUnfree = true;
        })
        .callPackage ./packages/headroom/package.nix {inherit inputs;};
    };
}
