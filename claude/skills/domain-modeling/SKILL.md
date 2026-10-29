---
name: domain-modeling
description: Use when describing a business domain as a model before implementation. Writes data and behavior in a mini-language built from data/behavior/AND/OR/-> , expressing states as sum types instead of boolean flags.
---

# Domain Modeling Skill

ドメイン記述ミニ言語を使ってドメインモデルを記述するスキル。

## Instructions

ユーザーから業務ドメインの説明を受け取り、以下のミニ言語の構文に従ってドメインモデルを出力する。

### 構文

4つのキーワードと記号で業務概念を表現する:

- `data`: データ構造定義
- `behavior`: 振る舞い定義
- `=`: 定義の左辺と右辺を結ぶ
- `AND`: すべての要素が必要
- `OR`: 複数の選択肢から1つを選ぶ(直和型)
- `->`: 入力から出力への変換
- `//`: コメント(制約条件など)

### データ定義

#### 単純な値(制約はコメントで付記)

```
data 名前 = 文字列  // 2〜100文字
data 年齢 = 整数    // 0〜150
```

#### 単位を持つ値(物理量は型として分離)

```
data 個数 = 整数         // 1以上
data キログラム = 数値   // 0.001以上
data 金額 = 整数         // 0以上、円単位
```

#### 複合データ(AND: 構成要素がすべて必要)

```
data 注文 = 注文番号 AND 住所
data 顧客 = 顧客ID AND 名前 AND 連絡先
```

#### 選択データ(OR: 複数の場合から1つを選択)

```
data 連絡先 = メールアドレス OR 電話番号
data 注文数量 = 個数 OR キログラム
```

#### コレクション

```
data 注文 = 注文番号 AND 顧客情報 AND List<注文明細>
data 書籍 = ISBN AND タイトル AND List<著者>  // 著者は1人以上
```

#### オプショナル(必須でない要素に ? を付記)

```
data 顧客 = 氏名 AND メールアドレス? AND 電話番号?
```

### 振る舞い定義

```
behavior 振る舞い名 = 入力データ -> 出力データ
```

成功と失敗はORで表現する:

```
behavior 注文を検証する = 未検証注文 -> 検証済み注文 OR 検証エラー
behavior 在庫を引き当てる = 製品コード AND 数量 -> 引当済み OR 在庫不足エラー
```

### 設計原則

1. **フラグではなくORで状態表現**: 真偽値フラグを使わず、状態を型で明示する
   ```
   // NG: data 注文 = 注文番号 AND 承認済みフラグ
   // OK:
   data 注文 = 未承認注文 OR 承認済み注文 OR キャンセルされた注文
   ```

2. **状態遷移をbehaviorで表現**: 状態ごとに異なる構造を持たせ、遷移をbehaviorとして定義する
   ```
   data 未承認注文 = 注文番号 AND 顧客名 AND 商品リスト
   data 承認済み注文 = 注文番号 AND 顧客名 AND 商品リスト AND 承認者 AND 承認日時

   behavior 注文を承認する = 未承認注文 AND 承認者 -> 承認済み注文 OR 承認失敗
   ```

3. **共通部分の抽出と合成**: 継承ではなくANDで合成する
   ```
   data 注文共通 = 注文番号 AND 顧客ID AND List<注文明細>
   data 未承認注文 = 注文共通 AND 見積有効期限
   data 承認済み注文 = 注文共通 AND 承認者 AND 承認日時
   ```

4. **局所的な選択肢は分離**: 差分だけをORで切り出す
   ```
   data 配送方法 = 通常配送 OR 冷蔵配送 OR 冷凍配送
   data 注文 = 注文番号 AND 顧客ID AND List<注文明細> AND 配送方法
   ```

5. **条件判定に名前を付ける**: 仕様の言葉をモデルに組み込む
   ```
   behavior 高額か判定する = 金額 -> 通常 OR 高額
   ```

6. **命名は短く簡潔に**: Prefix/Suffixは不要
7. **必須項目を ? で隠さない**: 業務が成立しない情報は必須のままにする

## User Instructions

$ARGUMENTS
