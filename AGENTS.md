# AGENTS.md

## プロジェクト概要

kawasimaのdotfilesリポジトリ。macOSとLinuxの複数端末で設定を共有するための設定ファイル置き場。

## 重要なルール

### 機密情報の禁止

このリポジトリはGitHubのPublicリポジトリである。パスワード、APIトークン、秘密鍵、プロキシ設定などの機密情報は絶対にコミットしないこと。

環境固有・機密性のある設定は別ファイルにinclude/sourceで分離し、`.gitignore`に登録する。既存の分離パターン（`.gitconfig`からの`.gitconfig.proxy`のinclude、Emacsの`init-proxy.el`の条件付きloadなど）に倣うこと。

### インストールスクリプトとの整合性

設定ファイルは `install/install.sh` 経由で各端末に反映される。`bin/slink.sh` がホームディレクトリへのシンボリックリンクを作成する仕組みになっている。

新しい設定ファイルを追加した場合は、`bin/slink.sh` のリンク対象リストにも追加すること。

### クロスプラットフォーム対応

macOSとLinuxの両方で動作する必要がある。

- OS固有の機能はOS判定で分岐するか、存在しない場合にエラーにならない構成にする
- パスは `/opt/homebrew`（macOS ARM）と `/usr/local`（macOS Intel / Linux）の両方を考慮する
- WSL環境も想定に含まれる

### Emacs設定の追加

- `~/.emacs.d/init/` 配下に `init-<名前>.el` として言語・機能別モジュールを作成し、`init.el` から読み込む
- パッケージ管理は `use-package` を使用する
