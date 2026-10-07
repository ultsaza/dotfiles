# LinuxからmacOSへのCLI対応

2026-10-08に、Linuxのユーザー用PATH、Nixプロファイル、npmのグローバルパッケージ、uv tool、Cargo、Goと手動導入のAPTパッケージを調査しました。OSの全システムバイナリやライブラリではなく、利用者が追加したCLIとそのランタイムを対象にします。認証情報、履歴、プロジェクトの依存関係は移しません。

## 導入と更新

HomebrewとXcode Command Line Toolsを用意して実行します。

```sh
chezmoi git pull --ff-only
bash "$(chezmoi source-path)/scripts/install-cli-tools.sh" --plan
bash "$(chezmoi source-path)/scripts/install-cli-tools.sh"
chezmoi diff
chezmoi apply
exec zsh -l
bash "$(chezmoi source-path)/scripts/install-cli-tools.sh" --check
```

初回は先に`chezmoi init https://github.com/ultsaza/dotfiles.git`を実行します。スクリプトはBrewfileを導入後、不足している追加CLIをインストールし、最後にコマンドの有無を確認します。すでにPATH上にある追加CLIは上書きしません。個別の更新は`npm`、`uv tool upgrade`、`cargo install`、`coursier update`や各CLIの更新機能で行ってください。失敗したツールは名前を表示して非ゼロ終了し、ほかの追加ツールの導入を続けます。同じコマンドで再試行できます。

`--plan`は導入コマンドの表示、`--check`はPATH上の存在確認です。`--check`はサービス、ログイン、ブラウザ、モデル推論の動作を検証しません。chezmoiの適用だけでインストールやサービス起動を行うことはありません。TeX、LLVM、JDK、Sageなどは大きなダウンロードになります。Nixはデーモンを導入し、Nix／Devboxやpkg形式のアプリは管理者権限を求めることがあります。

## 対応表

| Linuxで導入されていたCLI | macOSの導入元 |
| --- | --- |
| `chezmoi`、`git`、`git-lfs`、`gh`、`jj`、`hg`、`lazygit` | Homebrew |
| `nvim`、`hx`、`zsh`、`ksh` | Homebrew |
| `rg`、`fd`、`fzf`／`fzf-tmux`、`bat`、`eza`、`lsd`、`jq` | Homebrew。旧`exa`は`eza`へのリンクを作成 |
| `direnv`、`zoxide`、`btop`、`hyperfine`、`tokei`、`tldr`、`fastfetch`、`screenfetch`、`inxi`、`clock-rs` | Homebrew。無効化済みの`tldr` formulaに代えて`tlrc`を使用 |
| `ls`／`cp`／`stat`／`readlink`／`sha256sum`／`timeout`など、`find`／`xargs`、`sed`、`tar`、`grep`、`awk`、`getopt`、`diff`、`gzip`、`make` | GNU版をHomebrewから導入。ZshのPATHで通常の名前を優先 |
| `curl`、`wget`、`rsync`、`zip`、`unzip`、`7z`相当、`unar`、`lzip` | Homebrew。7-ZipのMac側コマンドは`7zz` |
| `aws`／`aws_completer`、`rclone`、`nmap`／`ncat`、`gpg`、`wg`／`wg-quick`、`tailscale` | Homebrew |
| `docker`、`docker compose`、`docker buildx` | Docker Desktop cask。初回にアプリを開いてセットアップ |
| `node`、`npm`／`npx`、`pnpm`／`pnpx`、`bun`／`bunx`、`corepack`、`tsc`／`tsserver` | Homebrew。NVMも導入し、Zshで読み込み |
| `python3.12`、`python3.13`、`uv`／`uvx` | Homebrew |
| `go`／`gofmt`、`gopls`、`staticcheck` | Homebrew |
| `cargo`、`rustc`、`rustfmt`、`clippy-driver`、`rust-analyzer`、Rustのデバッガー補助 | Homebrew rustup＋既定のstableツールチェーン・コンポーネント |
| `java`／`javac`、`sbt`、`scala-cli`、`coursier` | Temurin 17／25 caskとHomebrew。JDKは`java_home`で検出 |
| `cs`、`scala`、`scalac`、`amm`、`scalafmt`、`sbtn` | Coursierのアプリカタログ |
| `swift`／`swiftc`、SwiftのSDK補助、`swiftly` | XcodeのツールチェーンとHomebrew swiftly。追加版は`swiftly init --no-modify-profile`で導入 |
| `clang`／`clang++`／`clangd`、LLVMツール、`lld`／`lldb`、GNU GCC／GDB | Homebrew LLVM／LLD／LLDB／GCC／GDB。GCCはバージョン付き実行名も使用 |
| `cmake`、`ninja`、`pkg-config`、`meson`、`bison`、`flex`、`cppcheck`、`doxygen`、`glslangValidator`、`scdoc`、`gettext` | Homebrew |
| `ffmpeg`／`ffprobe`／`ffmpegthumbnailer`、ImageMagick、Graphviz、Poppler、`pandoc`、`qalc`、`potrace`、`jp2a`、`ohcount`、`osslsigncode`、`yt-dlp`、`mpv` | Homebrew |
| `qemu-system-*`、LaTeX／日本語TeX | Homebrew QEMU／TeX Live |
| `sage` | Sage cask。配布pkgが`/usr/local/bin/sage`を作成 |
| `adb`、`fastboot`、`code`、`zed`、`codex`、`claude`、`codexbar` | macOS用cask |
| `gws`、`herdr`、`ollama`、`agent-browser`、`kimi` | Homebrew。Kimiは後継の`kimi-code`を使用 |
| `gemini`、`vercel`／`vc`、`http-server`、`pug`、`zx` | npm。ユーザーの`~/.local`に導入 |
| `hf`、`kaggle`、`browser-use`とその別名 | uv tool＋Python 3.13 |
| `captube`、`cargo-deb`、`wallust` | Cargo |
| `gof5` | `go install github.com/kayrus/gof5/cmd/gof5@latest` |
| `ax`、`ctx`、`ntn`、`codon`、`vp`／`vpx`／`vpr`、`nix`、`devbox` | 公式のmacOS対応インストーラー |
| `home-manager` | Nixプロファイル |
| `moon`、`moonc`、`moonfmt`、`moonrun`、`mooncake`、`moondoc`、`mooninfo`、`moonbit-lsp` | 公式MoonBit SDK。最新版はApple Siliconのみ |
| `hermes` | 公式CLIインストーラー。現在のサポート対象はApple Silicon |
| `pokemon-colorscripts` | 公開元のPythonスクリプトと配色データをユーザー領域に配置 |

Homebrewの導入一覧は[Brewfile](../Brewfile)、追加CLIは[packages.tsv](../.chezmoitemplates/cli/packages.tsv)、存在確認の対象は[commands.txt](../.chezmoitemplates/cli/commands.txt)で管理します。Homebrew Formula／Cask APIで全エントリの存在と無効化・非推奨の状態を確認しました。Homebrewで非推奨になっているGeminiはnpmの公式配布を使い、旧Kimi CLIは後継のKimi Code CLIに切り替えます。

## 初回に行うセットアップ

- GitHubは`gh auth login`、AWSは必要なプロファイルの`aws configure sso`などをMacで実行します。AI CLI、Notion、Google Workspace、Hugging Face、Kaggle、VPNなども各端末で認証します。
- Docker Desktopを開いて初期設定し、`docker version`、`docker compose version`、`docker buildx version`を確認します。Linuxコンテナの実行はMac上のLinux VMを使います。
- `agent-browser install`でChromiumを導入します。browser-useもブラウザの追加導入が必要な場合があります。Ollamaのサービス起動とモデル取得は別途行います。
- `ctx`のインストーラーはバイナリだけ導入します。履歴の索引作成・デーモン・スキル導入は`ctx setup`等を明示的に実行してください。Linuxにあったローカルパッチは最新版の公式CLIにコピーしません。
- `hermes`の初期認証・ブラウザ・コンピューター操作は導入時に設定しません。必要に応じて`hermes setup`／`hermes pm install`を実行します。
- GDBのコード署名やmacOSのデバッグ権限は別途必要です。保存済みのLinux用GDB設定はMacへ配置しません。

## そのまま移せないもの

| Linux側のツール・構成 | macOSでの扱い |
| --- | --- |
| Hyprland／`hyprctl`／Hypr系、Waybar、Rofi、AGS、SwayNC、wlogout、grim／slurp／swappy、swww、wl-clipboard／cliphist、WayVNC／wf-recorder、nwg-displays、専用GUIランチャー | Linux／Waylandのデスクトップ専用。Macには配置しない。クリップボードは`pbcopy`／`pbpaste`、アプリ起動は`open` |
| `systemctl`、APT／dpkg、NetworkManager、PipeWire／WirePlumber、pamixer／playerctl、brightnessctl、LinuxのGPU／カーネル／EFI操作 | Linux固有。MacではHomebrew、launchctl、pmset等を目的に応じて使用。互換名で置き換えたふりはしない |
| `riscv64-linux-gnu-*`、Linux向けELF、Linuxパッケージ生成 | Linuxコンテナ・VMまたはLinuxホストで実行。Macには裸のRISC-V向け`riscv64-elf-*`も導入するが、Linux向けABIと同一ではない |
| MoonBit／Hermesの最新版をIntel Macで使用 | 上流の対応外。スクリプトは`UNSUPPORTED`を表示してスキップ。両方とも対応状況が変わればmanifestを更新 |
| `wpush` | 端末固有の転送スクリプト。接続先・認証情報を含み得るため共有しない。Mac用の接続設定とスクリプトは端末側で用意 |
| VialのLinux AppImage、その他GUI／OS部品 | CLI一覧から除外。Vial caskは現在無効化されているためBrewfileに追加しない |
| SDK内のバージョン付きバイナリ・WebAssemblyファイル・内部補助ツール | 対応SDKのmacOS版を使う。Linuxのバイナリをコピーしない |

公式の確認先: [Homebrew Formula API](https://formulae.brew.sh/api/formula.json)、[Cask API](https://formulae.brew.sh/api/cask.json)、[GNU coreutilsのPATH](https://formulae.brew.sh/formula/coreutils)、[Coursier](https://get-coursier.io/docs/cli-install)、[Sage macOS](https://github.com/3-manifolds/Sage_macOS)、[MoonBit](https://www.moonbitlang.com/download)、[Hermesの対応プラットフォーム](https://github.com/NousResearch/hermes-agent/blob/main/website/docs/getting-started/platform-support.md)、[Codon](https://docs.exaloop.io/start/install/)、[Vite+](https://www.viteplus.dev/guide/global-cli)、[Notion CLI](https://developers.notion.com/cli/get-started/overview)、[ctx](https://github.com/ctxrs/ctx)、[ax](https://github.com/yusukebe/ax)、[gof5](https://github.com/kayrus/gof5)、[pokemon-colorscripts](https://gitlab.com/phoneybadger/pokemon-colorscripts)。
