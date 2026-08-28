{
  # GUI アプリ・Homebrew でしか入手できないツールの管理
  # (Nix で入る CLI ツールは home/default.nix を参照)
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      # 注意: cleanup = "uninstall" を設定すると Homebrew (Nix 管理外) の
      # アプリが全て削除されるため設定しないこと
    };

    # homebrew/* の公式 tap は常に trusted 扱い。
    # 非公式 tap は Homebrew 6.0 の HOMEBREW_REQUIRE_TAP_TRUST により
    # trusted = true を付けないと activate 時に trust 確認を求められる
    taps = [
      "homebrew/bundle"
      "homebrew/services"
      {
        name = "FelixKratz/formulae";
        trusted = true;
      }
      {
        name = "getagentseal/codeburn";
        trusted = true;
      }
      {
        name = "nikitabobko/tap";
        trusted = true;
      }
      {
        name = "filosottile/musl-cross";
        trusted = true;
      }
    ];

    # nixpkgs に存在しないもの・自己更新を行うバージョンマネージャのみ
    # (mise は nixpkgs から導入し、更新も flake 経由で行う)
    brews = [
      # バージョンマネージャ (自己更新するため Homebrew 管理のまま)
      "ghcup"

      # nixpkgs に存在しないツール (または Linux 専用のため移行不可)
      "borders"
      "codeburn"
      "datadog/lapdog/lapdog"
      "sheeki03/tap/tirith"
      "JetBrains/utils/kotlin-lsp"
      "filosottile/musl-cross/musl-cross"
      "icarus-verilog"
      "unbound"
      "tpm"
      "rustnet"
      "llvm"

      # GUI アプリ本体 (CLI だけの移行は不可)
      "wireshark"
    ];

    casks = [
      "1password"
      "alt-tab"
      "nikitabobko/tap/aerospace"
      "aws-vault"
      "bloomrpc"
      "caffeine"
      "chromium"
      "claude-code"
      "codex"
      "font-hack-nerd-font"
      "font-jetbrains-mono"
      "font-sketchybar-app-font"
      "font-udev-gothic-nf"
      "google-chrome"
      "google-japanese-ime"
      "hot"
      "karabiner-elements"
      "keycastr"
      "lens"
      "mic-drop"
      "ngrok"
      "notion"
      "obsidian"
      "opencode-desktop"
      "orbstack"
      "raycast"
      "slack"
      "spotify"
      "tableplus"
      "ubersicht"
      "visual-studio-code"
      "wezterm"
      "xquartz"
      "zed"
    ];
  };

  # brew services 経由ではなく nix-darwin が LaunchAgent を管理する
  # プラグインから codeburn / aerospace CLI (Homebrew 側) を呼ぶため PATH に追加
  services.sketchybar.enable = true;
  launchd.user.agents.sketchybar = {
    path = [ "/opt/homebrew/bin" ];
    environment = {
      LANG = "en_US.UTF-8";
    };
  };
}
