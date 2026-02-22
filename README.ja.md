# oracle

[Claude Code](https://claude.com/claude-code)向けのクロスモデル検証ツール。Claudeと[Codex (GPT-5.3)](https://github.com/openai/codex)を連携し、コードレビュー、代替実装、アーキテクチャ検証のセカンドオピニオンを取得します。

[한국어](README.md) | [English](README.en.md) | [Tiếng Việt](README.vi.md)

## なぜ必要？

AIモデルにはそれぞれ得意分野と盲点があります。2つ目のモデルにコードをレビューしてもらうことで、1つのモデルでは見落とす問題を検出できます。Oracleはこのクロス検証ワークフローを自動化します。

## 前提条件

- [Claude Code](https://claude.com/claude-code) インストール済み
- [Codex CLI](https://github.com/openai/codex) インストール済み + OpenAI APIキー設定済み

```bash
npm install -g @openai/codex
```

## インストール

### 方法A: プラグイン（推奨）

[Claude Codeプラグインシステム](https://docs.anthropic.com/en/docs/claude-code/plugins)でインストール。`/oracle:ask` が使用可能になります。

```bash
# マーケットプレイス追加
/plugin marketplace add wanbok/claude-marketplace

# プラグインインストール
/plugin install oracle@wanbok-claude-marketplace
```

### 方法B: スクリプトインストール

リポジトリをクローンしてインストールスクリプトを実行。`/oracle` スキル + `oracle` エージェントが使用可能になります。

```bash
git clone https://github.com/wanbok/oracle.git
cd oracle
chmod +x install.sh
./install.sh
```

`~/.claude/agents/` にエージェントを、`~/.claude/skills/` にスキルをシンボリックリンクでインストールします。

> **注意:** インストール方法は1つだけ選択してください。oracleプラグイン（方法A）がインストールされている場合、`oracle` ネームスペースをプラグインが占有するため、方法Bの `/oracle` ローカルスキルは認識されません。プラグインは `/oracle:ask`、スクリプトは `/oracle` で使用し、同時インストールはサポートしていません。

## 使い方

### スキルとして使用

```
/oracle この関数のエッジケースをレビューして
/oracle:ask この関数のエッジケースをレビューして   # プラグインインストール時
```

どちらも同じ5ステップワークフローを実行します：パース → コンテキスト収集 → Codex呼び出し → 品質検証 → レポート。

### カスタムエージェントとして使用

Taskツールで `oracle` を `subagent_type` に指定：

```
Task(subagent_type="oracle", prompt="このコードのセキュリティ問題をレビューして: ...")
```

### チームロールとして使用

エージェントチームに `oracle` ロールを追加して、開発中の継続的なクロスモデル検証を実行します。[examples/team-usage.md](examples/team-usage.md) 参照。

## 動作の仕組み

```
質問を入力
   │
   ▼
Oracleが関連コードを
読み取り (Read/Grep)
   │
   ▼
インラインコードコンテキストで
プロンプトを構成
   │
   ▼
Codex CLIに送信
(タイムアウト: 180秒)
   │
   ▼
Codexの応答を
品質検証
   │
   ▼
検証済みの結果を
レポート
```

Oracleは**読み取り専用**です — ファイルを変更しません。提案のみ行い、適用はユーザーが判断します。

## バックエンド設定

デフォルトは[Codex CLI](https://github.com/openai/codex)ですが、`agents/oracle.md` の `codex exec` コマンドを編集して別のバックエンドに切り替えられます。

| バックエンド | コマンド | 備考 |
|-------------|---------|------|
| **Codex CLI**（デフォルト） | `codex exec "prompt"` | OpenAI APIキー必要 |
| **Ollama** | `ollama run llama3 "prompt"` | ローカル実行、無料、APIキー不要 |
| **OpenRouter** | `curl` でOpenRouter API呼び出し | マルチモデル、従量課金 |
| **Google Gemini** | `gemini "prompt"` | Google AI APIキー必要 |

バックエンドを変更するには、`agents/oracle.md` の "How to Call Codex" セクションで `codex exec` パターンを置き換えてください。

## アンインストール

```bash
./uninstall.sh
```

## ライセンス

MIT
