{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # Terminal utilities
    asciinema
    ast-grep
    bat
    btop
    delta
    difftastic
    eza
    fd
    fzf
    gh
    ghq
    gibo
    git-secrets
    gping
    grpcurl
    herdr
    hexyl
    htop
    hyperfine
    jq
    k9s
    kompose
    kubectl
    kubectx
    kustomize
    lcov
    lazydocker
    lazygit
    lolcat
    macchina
    marp-cli
    mise
    opencode
    peco
    poetry
    procs
    ripgrep
    sheldon
    sl
    starship
    terminal-notifier
    terraformer
    tmux
    tmuxinator
    xh
    yazi
    zellij
    goreleaser
    terraform
    _1password-cli
    uv
    awscli2
    bun
    chezmoi
    cmake
    coursier
    deno
    gnumake
    gawk
    guile
    kubernetes-helm
    lima
    maven
    neovim
    ninja
    openssh
    pkg-config
    protobuf
    qemu
    zig

    # Runtimes
    temurin-bin-21
    python313
    go
    gleam
    nodejs
    # PostgreSQL 18 is the default version exposed on PATH.
    # All managed versions are also available under ~/.local/opt/postgresql@<major>.
    postgresql_18

    (pkgs.callPackage ../packages/headroom/package.nix {inherit inputs;})

    # Cargo plugins
    cargo-chef
    cargo-features-manager
    cargo-make
    cargo-machete
    cargo-sort
    cargo-wizard
    mergiraf
  ];

  # PostgreSQL versions contain identically named binaries, so installing all
  # of them directly into home.packages would cause profile collisions.
  home.file = {
    ".local/opt/postgresql@15".source = pkgs.postgresql_15;
    ".local/opt/postgresql@16".source = pkgs.postgresql_16;
    ".local/opt/postgresql@17".source = pkgs.postgresql_17;
    ".local/opt/postgresql@18".source = pkgs.postgresql_18;
  };
}
