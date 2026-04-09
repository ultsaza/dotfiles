#!/usr/bin/env bash
# chezmoi:template:false
set -euo pipefail

if ! command -v code &>/dev/null; then
  echo "VSCode not found, skipping extension install"
  exit 0
fi

echo "Installing VSCode extensions..."

extensions=(
  1yib.rust-bundle
  aaron-bond.better-comments
  anthropic.claude-code
  arrrrny.zed-one-theme
  arrterian.nix-env-selector
  astral-sh.ty
  batisteo.vscode-django
  bbenoist.nix
  chadalen.vscode-jetbrains-icon-theme
  christian-kohler.npm-intellisense
  connor4312.esbuild-problem-matchers
  davidanson.vscode-markdownlint
  dbaeumer.vscode-eslint
  donjayamanne.githistory
  donjayamanne.python-environment-manager
  donjayamanne.python-extension-pack
  dotjoshjohnson.xml
  dustypomerleau.rust-syntax
  eamodio.gitlens
  enhancedjax.vscode-ayu-zed
  enkia.tokyo-night
  esbenp.prettier-vscode
  fill-labs.dependi
  formulahendry.code-runner
  ginfuru.ginfuru-better-solarized-dark-theme
  github.copilot-chat
  github.vscode-pull-request-github
  golang.go
  google.colab
  google.gemini-cli-vscode-ide-companion
  hylwxqwq.yuyuko-vim-vsc
  jackiotyu.git-worktree-manager
  james-yu.latex-workshop
  jebbs.plantuml
  jnoortheen.nix-ide
  jscearcy.rust-doc-viewer
  kevinrose.vsc-python-indent
  kevinyuan.vscode-tikzjax
  llvm-vs-code-extensions.lldb-dap
  lorenzopirro.rust-flash-snippets
  marp-team.marp-vscode
  mathematic.vscode-latex
  mechatroner.rainbow-csv
  mhutchie.git-graph
  mkhl.direnv
  ms-azuretools.vscode-containers
  ms-azuretools.vscode-docker
  ms-kubernetes-tools.vscode-kubernetes-tools
  ms-python.debugpy
  ms-python.python
  ms-python.vscode-python-envs
  ms-toolsai.jupyter
  ms-toolsai.jupyter-keymap
  ms-toolsai.jupyter-renderers
  ms-toolsai.vscode-jupyter-cell-tags
  ms-toolsai.vscode-jupyter-slideshow
  ms-vscode-remote.remote-containers
  ms-vscode.cmake-tools
  ms-vscode.cpp-devtools
  ms-vscode.cpptools
  ms-vscode.cpptools-extension-pack
  ms-vscode.cpptools-themes
  ms-vscode.extension-test-runner
  ms-vscode.makefile-tools
  nickfode.latex-formatter
  njpwerner.autodocstring
  panicbit.cargo
  qufiwefefwoyn.kanagawa
  redhat.java
  redhat.vscode-yaml
  rust-lang.rust-analyzer
  scala-lang.scala
  scalameta.metals
  tamasfe.even-better-toml
  teabyii.ayu
  tomoki1207.pdf
  torn4dom4n.latex-support
  ultsaza.atcoder-commiter
  visualjj.visualjj
  visualstudioexptteam.intellicode-api-usage-examples
  visualstudioexptteam.vscodeintellicode
  vscjava.vscode-gradle
  vscjava.vscode-java-debug
  vscjava.vscode-java-dependency
  vscjava.vscode-java-pack
  vscjava.vscode-java-test
  vscjava.vscode-maven
  vscodevim.vim
  wesbos.theme-cobalt2
  wholroyd.jinja
  yzhang.markdown-all-in-one
)

for ext in "${extensions[@]}"; do
  code --install-extension "$ext" --force 2>/dev/null || true
done

echo "Done!"
