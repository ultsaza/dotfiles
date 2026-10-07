# dotfiles

chezmoiで管理するLinux／macOS用の設定です。2026-10-08時点のLinux環境を取り込み、macOSではOS固有の設定と配置先を切り替えます。

| 設定 | Linux | macOS |
| --- | --- | --- |
| Zsh、Powerlevel10k、Neovim、lazygit | 共通設定 | 共通設定、Homebrewの初期化 |
| VS Code | `~/.config/Code/User` | `~/Library/Application Support/Code/User` |
| Ghostty | `~/.config/ghostty/config` | `~/Library/Application Support/com.mitchellh.ghostty/config` |
| デスクトップ・キー設定 | HyprlandのLua設定 | Karabiner-ElementsのHyperキー |
| デスクトップ周辺 | Waybar、Rofi、SwayNC、wallust、wlogout、WirePlumber | 配置しない |

VS Codeの配置先は[公式の設定ファイル仕様](https://code.visualstudio.com/docs/configure/settings#_user-settingsjson-location)、OSによる除外は[chezmoiの`.chezmoiignore`](https://www.chezmoi.io/reference/special-files/chezmoiignore/)に従います。既定の`~/.config`配置を前提としています。

## macOSの初期設定

[Homebrew](https://brew.sh/)とXcode Command Line Toolsを用意してから実行します。

```sh
xcode-select --install
brew install chezmoi
chezmoi init https://github.com/ultsaza/dotfiles.git
bash "$(chezmoi source-path)/scripts/install-cli-tools.sh"
chezmoi diff
chezmoi apply
bash "$(chezmoi source-path)/scripts/install-vscode-extensions.sh"
```

CLI導入スクリプトはBrewfileのアプリとCLIに加え、npm／uv／Cargo／Go／Coursierと公式インストーラーのツールも導入します。`gh`、AWS CLI、Docker、Node／NVM／pnpm／Bun、Rust／Go、Java／Scala、AI系CLI、画像・動画・PDF処理を含みます。Linux環境からの対応表、追加セットアップ、OS・CPUによる制約は[docs/cli-tools.md](docs/cli-tools.md)を参照してください。TeX、LLVM、JDKなども入るため、初回は大きなダウンロードになります。Nix、Devboxやパッケージ形式のアプリは管理者権限を求める場合があります。

Apple Siliconの`/opt/homebrew`とIntelの`/usr/local`をZshで判別し、非対話シェルにもHomebrewを設定します。GNU版の`sed`／`find`／`grep`なども通常の名前で使えるPATHにします。インストール内容を先に確認する場合は同じスクリプトに`--plan`、導入後の不足を確認する場合は`--check`を指定します。chezmoiの適用だけではパッケージの導入を実行しません。

Karabiner-ElementsにはCapsLockを`Cmd+Ctrl+Option`のHyperキー、単押しをEscapeにする設定とJISキーボード設定を保存しています。Karabiner-Elementsに必要な権限も許可してください。

Ghosttyの背景・文字・カーソル・ANSI 16色はLinuxの配色を共通テンプレート`.chezmoitemplates/ghostty/colors.conf`で管理します。macOSのフォントサイズ、透過、ぼかし、ウィンドウ設定は端末向けの設定を使います。壁紙を使う場合は、その端末にある画像を`background-image`で指定してください。

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

Zshのローカル設定は`~/.zshrc.local`へ置きます。VPNやSSHの接続先、認証情報、追加のエイリアスをここに記載できます。このファイルはGitにもchezmoiの管理対象にも入れません。共通の`ssh-mini`エイリアスは`code --remote ssh-remote+mini`を実行します。接続先は各端末の`~/.ssh/config`で定義し、SSH設定・鍵は管理対象から除外します。Neovimは既存の`PATH`から解決し、LinuxのJavaインストール先を固定しません。独自の導入先や`JAVA_HOME`が必要な場合は`~/.zshrc.local`へ設定します。macOSでは既存の`JAVA_HOME`を優先し、未設定の場合に`/usr/libexec/java_home`で導入済みJDKを検出します。Oh My Zshと追加プラグインは導入済みのものだけを読み込み、未導入でもシェルを起動できます。

Claude CodeとCodexの設定ディレクトリ（`~/.claude`、`~/.codex`）はchezmoiの管理対象から除外しています。モデル／UIの好み、APIキー、プロジェクト信頼設定、フック、プラグインは各端末で管理します。以前の管理対象から外しても、端末にある設定ファイルは削除しません。

VS CodeのmacOS設定・キーバインドと共通の拡張一覧は、2026-10-08時点のMacで使っている構成を保存しています。Linuxの設定・キーバインドは別テンプレートです。拡張は上記スクリプトを明示的に実行して導入します。失敗した拡張は表示して非ゼロ終了し、同じコマンドで再試行できます。C++ビルドタスクはLinuxで`g++`、macOSで`clang++`を使います。macOSのC++補完の既定値は`/usr/bin/clang++`です。導入済みのJetBrainsMono Nerd Fontをターミナルで使い、保存済みのGDBデバッグ設定はLinuxだけに配置します。

Mac固有のVS Code設定は`~/.config/dotfiles/vscode.local.json`へ保存します。JSON／JSONC形式で、macOS設定へ重ねてローカルの値を優先します。このファイルはGitにもchezmoiの管理対象にも入りません。既存の`remote.SSH.*`や独自の`C_Cpp.default.compilerPath`をここへ移しておけば、再適用してもその端末の接続先・コンパイラー設定を保持できます。

`~/dotfiles`を適用元にする場合は、`~/.config/chezmoi/chezmoi.toml`で`sourceDir = "/絶対パス/dotfiles"`を指定します。`chezmoi source-path`で参照先を確認してから適用してください。

## シェルの配色と補完

Powerlevel10kのプロンプトは両OSで同じ`~/.p10k.zsh`を使います。入力中のコマンドは`zsh-syntax-highlighting`で色を付け、コメントはLinuxと同じ`fg=244`にします。Linuxでは導入済みのOh My Zshプラグインを読み込み、macOSではBrewfileから`zsh-syntax-highlighting`と`zsh-autosuggestions`を導入して読み込みます。Oh My ZshがなくてもMacの配色と履歴候補は有効になります。

Tab補完はOh My Zshの初期化を利用し、未導入ならZshの`compinit`を実行します。候補メニュー、大文字小文字を区別しない照合、部分一致を共通設定にしています。macOSではHomebrewの補完と`zsh-completions`を初期化前に`fpath`へ加えます。[Homebrewの補完手順](https://docs.brew.sh/Shell-Completion)と[追加補完の導入方法](https://formulae.brew.sh/formula/zsh-completions)に沿った配置です。

入力中に薄い文字で表示する候補は、`zsh-autosuggestions`による履歴ベースの提案です。行末で右矢印を押すと採用します。履歴は`~/.zsh_history`へ保存して複数のシェルで共有し、先頭が空白のコマンドと連続した重複は保存しません。履歴を持たない初回のシェルでは候補もありません。AIによる提案は追加の`zsh-ai`と接続先が必要で、Brewfileによる基本構成には含めません。

既存のMacへこの構成を取り込む場合は、`chezmoi git pull --ff-only`、`bash "$(chezmoi source-path)/scripts/install-cli-tools.sh"`、`chezmoi diff`、`chezmoi apply`の順に実行してから新しいシェルを開きます。

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

Linux、macOS arm64／amd64の設定を空白入りの一時ホームへ実際に展開し、配置先、OS固有ファイルの除外、シェル起動、JSON、起動リンク、再適用の安定性を確認します。既存のSSH・Claude・Codex設定の保持と、Mac固有のVS Code設定の優先も検証します。疑似端末でTabキーを入力し、`git --ver`から`git --version`への引数補完と履歴保存も確認します。GitHub ActionsではUbuntuとmacOSで実行し、macOSでは実際のHomebrewプラグインの読み込みも確認します。Macでローカルテストを実行する場合もBrewfileのプラグインを導入してください。テストは実際のホームへ適用せず、拡張のインストールやデスクトップの再起動も行いません。GUIアプリの実動作と権限設定は各端末で確認してください。
