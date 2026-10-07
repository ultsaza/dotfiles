# dotfiles

chezmoiで管理するLinux／macOS用の設定です。2026-10-07時点のLinux環境を取り込み、macOSではOS固有の設定と配置先を切り替えます。

| 設定 | Linux | macOS |
| --- | --- | --- |
| Zsh、Powerlevel10k、Neovim、lazygit | 共通設定 | 共通設定、Homebrewの初期化 |
| VS Code | `~/.config/Code/User` | `~/Library/Application Support/Code/User` |
| Ghostty | `~/.config/ghostty/config` | `~/Library/Application Support/com.mitchellh.ghostty/config` |
| デスクトップ・キー設定 | HyprlandのLua設定 | Karabiner-ElementsのHyperキー |
| デスクトップ周辺 | Waybar、Rofi、SwayNC、wallust、wlogout、WirePlumber | 配置しない |
| Claude Code、Codex | 移植可能な個人設定 | 同じ個人設定 |

VS Codeの配置先は[公式の設定ファイル仕様](https://code.visualstudio.com/docs/configure/settings#_user-settingsjson-location)、OSによる除外は[chezmoiの`.chezmoiignore`](https://www.chezmoi.io/reference/special-files/chezmoiignore/)に従います。既定の`~/.config`配置を前提としています。

## macOSの初期設定

[Homebrew](https://brew.sh/)とXcode Command Line Toolsを用意してから実行します。

```sh
xcode-select --install
brew install chezmoi
chezmoi init https://github.com/ultsaza/dotfiles.git
brew bundle --file="$(chezmoi source-path)/Brewfile"
chezmoi diff
chezmoi apply
bash "$(chezmoi source-path)/scripts/install-vscode-extensions.sh"
```

`Brewfile`には共通CLI、Ghostty、VS Code、Karabiner-Elements、フォントを記載しています。Apple Siliconの`/opt/homebrew`とIntelの`/usr/local`をZshで判別します。Node.js／NVMや各言語のSDKは必要に応じて別途導入してください。

Karabiner-ElementsにはCapsLockを`Cmd+Ctrl+Option`のHyperキー、単押しをEscapeにする設定とJISキーボード設定を保存しています。Karabiner-Elementsに必要な権限も許可してください。

GhosttyのmacOS用の色、透過、フォントサイズは既存の設定を引き継いでいます。壁紙を使う場合は、その端末にある画像を`background-image`で指定してください。

## Linuxの初期設定

chezmoi、Zsh、Neovim、lazygit、jq、direnv、zoxide、lsd、fastfetch、Nerd Fontなど、利用するアプリを先に導入します。デスクトップ設定はJaKooLitの構成をベースにしており、Hyprlandだけの導入では周辺機能を再現できません。

```sh
chezmoi init https://github.com/ultsaza/dotfiles.git
chezmoi diff
chezmoi apply
bash "$(chezmoi source-path)/scripts/install-vscode-extensions.sh"
```

Hyprlandは[ultsaza/hyprの`v0.55+`ブランチ](https://github.com/ultsaza/hypr/tree/v0.55%2B)を参照したLua専用構成です。参照コミットは`55ea356e35b6c14f1885f8068a016ee325da3081`で、Hyprland 0.56.2を基準にしています。Lua設定を読み込めるHyprlandと、`hyprctl`のLua IPCに対応するWaybarなどを用意してください。旧Hyprlandの`.conf`と無効化済みコードは管理対象から除き、Hypridle／Hyprlock／ポータル／Qt用の`.conf`とHyprlockが読む配色ファイルは維持します。参照元とdotfiles側で保持する差分は[docs/hypr-source.md](docs/hypr-source.md)に記載しています。

周辺機能にはWaybar、Rofi、SwayNC、wallust、wlogout、swww、hypridle／hyprlock、kitty、Thunar、wl-clipboard／cliphist、grim／slurp／swappy、PipeWire／WirePlumber、NetworkManager、Polkit、fcitx5／Mozcなどを使用します。Quickshellのoverview、AGS、壁紙画像、各アプリのバイナリは別途用意してください。

`~/.config/hypr/monitors.lua`は現在の2画面配置を保存しています。適用前に自分の出力名、解像度、位置へ変更してください。ディスプレイ設定ツールを使う場合も、Lua側が更新されることを確認してください。Hyprlandの既定エディターは参照元と同じ`nvim`です。

Ghostty／Zoom／画面共有ピッカーは専用のFontconfigキャッシュを使います。`~/.local/bin`の起動リンクから利用でき、Zoomのアプリ一覧用エントリも配置します。XDPHは`force_shm`と専用ピッカーを選択します。Zoomの実行ファイルは`/usr/bin/zoom`、Ghosttyは`/usr/bin/ghostty`を前提とするLinux向け設定です。

`~/.config/hypr/tools`には現在のWaybarビルド定義とnwg-displays互換パッチを保存しています。これらのバイナリのビルドやインストールは自動実行しません。ラッパーを使う場合は、それぞれが参照する`~/.local/share`以下のバイナリを先に用意してください。

## 端末固有の設定と認証情報

APIキー、ログイン情報、シェル履歴、顧客データ、Codexのプロジェクト信頼設定、ローカルのフックやプラグインキャッシュパスは管理しません。

Zshのローカル設定は`~/.zshrc.local`へ置きます。VPNやSSHの接続先、認証情報、追加のエイリアスをここに記載できます。このファイルはGitにもchezmoiの管理対象にも入れません。Neovimは既存の`PATH`から解決し、LinuxのJavaインストール先を固定しません。独自の導入先や`JAVA_HOME`が必要な場合は`~/.zshrc.local`へ設定します。macOSでは`/usr/libexec/java_home`で導入済みJDKを検出します。Oh My Zshと追加プラグインは導入済みのものだけを読み込み、未導入でもシェルを起動できます。

Claude CodeとCodexの設定は現在のモデル／UIの好みを保存しています。APIキーをテンプレートでJSONやTOMLへ書き出しません。接続先やローカルのフックは端末ごとに追加し、再適用時には`chezmoi diff`で変更を確認してください。Codexの設定項目は[公式リファレンス](https://developers.openai.com/codex/config-reference/)を参照してください。

VS Code拡張は上記スクリプトを明示的に実行して導入します。失敗した拡張は表示して非ゼロ終了し、同じコマンドで再試行できます。C++ビルドはLinuxで`g++`、macOSで`clang++`を使います。macOSではC++補完にも`/usr/bin/clang++`を指定し、導入済みのJetBrainsMono Nerd Fontをターミナルで使います。保存済みのGDBデバッグ設定はLinuxだけに配置します。

## 日常の更新

```sh
# 管理中の設定との差分を見る
chezmoi status
chezmoi diff

# テンプレートを編集して適用する
chezmoi edit ~/.config/nvim/init.lua
chezmoi apply

# 実際の設定変更を取り込む。対象ファイルを指定する
chezmoi re-add ~/.config/nvim

# リモート更新を取り込み、差分確認後に適用する
chezmoi git pull --ff-only
chezmoi diff
chezmoi apply
```

テンプレートは`re-add`で上書きされません。共有するVS Code設定は`.chezmoitemplates/vscode`、OSごとの配置先はそれぞれの`*.tmpl`で管理します。

## 検証

Python 3.11以上、chezmoi、Zsh、Neovimで実行します。

```sh
cd "$(chezmoi source-path)"
python3 -m unittest discover -s tests -v
```

Linux、macOS arm64／amd64の設定を空白入りの一時ホームへ実際に展開し、配置先、OS固有ファイルの除外、シェル起動、JSON／TOML、起動リンク、再適用の安定性を確認します。GitHub ActionsでもUbuntuとmacOSで実行します。テストは実際のホームへ適用せず、拡張のインストールやデスクトップの再起動も行いません。GUIアプリの実動作と権限設定は各端末で確認してください。
