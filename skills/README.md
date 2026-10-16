# Skills lockfile

[.skill-lock.json](.skill-lock.json)は、2026-10-16時点の`~/.agents/.skill-lock.json`から保存した、`npx skills`のグローバルlockfile（version 3）です。取得元、skillのパス、ハッシュ、記録済みのrefと日時を保持し、CLIの選択履歴などの設定は除外しています。

このファイルは参照用です。`chezmoi apply`では配置せず、各端末のlockfileを上書きしません。また、ファイルの保存だけではskillsはインストールされません。プロジェクト用の`skills-lock.json`とは形式が異なり、`npx skills experimental_install`の入力には使えません。全件がコミット固定されているわけではありません。

## 記録されていないskills

同日時点の`npx skills list --global --json`では27件が表示されますが、元のlockfileに記録されているのは20件です。次の7件は導入済みでも取得元の記録がないため、このlockfileには含めていません。

- `ctx`
- `hf-cli`
- `notion-api`
- `notion-cli`
- `notion-pages`
- `reverse-engineer-anything`
- `typesafe-ai`

これらの取得元やインストール方法は、このスナップショットでは補完していません。

## スナップショットの更新

リポジトリのルートで実行します。

```sh
jq '{version, skills: (.skills | to_entries | sort_by(.key) | from_entries)}' \
  "$HOME/.agents/.skill-lock.json" > skills/.skill-lock.json
git diff -- skills/.skill-lock.json
```

更新時は`npx skills list --global --json`と照合し、上の件数・未記録一覧・保存日も更新してください。コミット前に、取得元が公開可能か確認し、認証情報や端末固有の絶対パスが混入していないことを確認してください。
