# Hyprlandの参照元と保持する差分

2026-10-07に[ultsaza/hypr](https://github.com/ultsaza/hypr)の既定ブランチ`v0.55+`を確認し、[コミット55ea356](https://github.com/ultsaza/hypr/commit/55ea356e35b6c14f1885f8068a016ee325da3081)を参照した。Hyprland 0.56.2を基準にしたLua専用構成である。

`private_dot_config/hypr`はレビュー済みのスナップショットとして管理する。`chezmoi apply`時に参照リポジトリを自動更新しない。更新時は参照元のコミットと差分を確認し、この記録を更新する。

## 取り込んだ構成

- Hyprland本体とプリセットはLuaを使用し、旧Hyprlandの`.conf`、`.disable`、旧キー解析コードを管理対象から除いた。
- Luaファイルの説明、画面プロファイルとユーザー設定のガイドを参照元に合わせた。
- 既定エディターは`nvim`とし、Hyprlandが起動するアプリへ`EDITOR`を設定する。
- 設定フォルダーを全置換する旧更新処理を除き、参照元と同じ案内用スクリプトを残した。

## dotfilesで保持する差分

- `monitors.lua`は2026-10-07の画面配置を保持する。参照元の古い位置には戻さない。
- `UserConfigs/01-UserDefaults.lua`の端末起動先は、専用Fontconfigキャッシュを使う`ghostty-launch`とする。
- Ghostty／Zoom／画面共有ピッカーの起動スクリプト、Zoomのdesktopエントリー、`xdph.conf`の専用ピッカー設定を保持する。
- `tools/nwg-displays.desktop`はユーザー名を含まない`Exec=nwg-displays`を使用する。
- スクリーンショット通知のタイムアウトなど、現在の設定にある追加修正を保持する。
- `wallust/wallust-hyprland.conf`はHyprlockの3種類の設定から読み込まれる配色変数として保持する。Hyprland本体はLua側の配色を使用する。

Hypridle、Hyprlock、ポータル、Qtスタイル用の`.conf`は各アプリが必要とする形式のまま維持する。参照元のREADME、移行記録、GPUを使うheadlessテストは[参照コミットのリポジトリ](https://github.com/ultsaza/hypr/tree/55ea356e35b6c14f1885f8068a016ee325da3081)から参照できる。

## 検証範囲

dotfilesのテストでは一時ホームへLinux／macOSの設定を展開し、Luaモジュールの参照、構文、配置先、起動リンクとシェル起動を確認する。実際のホームへの適用、Hyprlandのリロード、GUIの実動作確認は行わない。
