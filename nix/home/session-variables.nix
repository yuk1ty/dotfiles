{
  pkgs,
  ...
}: {
  # mise グローバル設定 (~/.config/mise/config.toml) から移行した
  # グローバルランタイムの環境変数。
  # 実体は dot_zshenv が /etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh
  # を source して適用する
  home.sessionVariables = {
    JAVA_HOME = "${pkgs.temurin-bin-21.home}";
  };
}
