# PDF化プログラム 使い方ガイド

このフォルダには、卒業論文・研究計画書・論文図をPDFに変換するためのプログラムと、卒論LaTeXテンプレート一式が含まれています。

---

## フォルダ構成

```
PDF化プログラム/
├── README.md                              # このファイル
├── 卒論フォーマット/                       # LaTeXテンプレート一式
│   ├── main.tex                           # メインのLaTeXファイル（ここを編集）
│   ├── my_bthesis.cls                     # 大分大学 卒業論文クラスファイル（変更不要）
│   ├── latexmkrc                          # latexmk設定ファイル（変更不要）
│   ├── build.sh                           # PDF生成スクリプト
│   └── chapters/
│       ├── 00_abstract.tex                # 要旨
│       ├── chapter1_intro.tex             # 第1章 序論
│       ├── chapter2_related_work.tex      # 第2章 関連研究
│       ├── chapter3_method.tex            # 第3章 提案手法
│       ├── chapter4_dataset_design.tex    # 第4章 データと実験設計
│       ├── chapter5_experiment1.tex       # 第5章 実験1
│       ├── chapter6_experiment2.tex       # 第6章 実験2
│       ├── chapter7_discussion.tex        # 第7章 考察
│       ├── chapter8_conclusion.tex        # 第8章 結論
│       ├── appendix_a.tex                 # 付録
│       └── 99_references.tex             # 参考文献リスト
├── thesis_build.sh                        # 既存の卒業論文PDFを再ビルド
├── research_plan_build.sh                 # 研究計画書PDFを生成
├── 27_generate_thesis_figures_tables.py   # 論文図をPDF/PNGで生成（本体）
├── generate_thesis_figures.py             # 上記の呼び出しラッパー
└── generate_all_thesis_artifacts.py       # 全アーティファクト（図・表）を一括生成
```

---

## 1. 卒論フォーマット（新規に論文を書く場合）

### 必要な環境

- **LuaLaTeX** または **latexmk**（TeX Liveに含まれる）
  - macOS: `brew install --cask mactex` でインストール可能
  - クラスファイル `my_bthesis.cls` は大分大学指定の様式（30文字×30行）を実装済み

### 手順

1. `卒論フォーマット/` フォルダをコピーして作業フォルダとして使う

2. `main.tex` の冒頭を編集してタイトル・氏名・日付を設定する

   ```latex
   \title{論文タイトル（日本語）}
   \etitle{Thesis Title in English}
   \author{氏名}
   \date{2027年2月}
   ```

3. `chapters/` 内の各 `.tex` ファイルに本文を書く

4. 図を使う場合は `figures/` フォルダを作成してPNG/PDFを配置し、以下のように挿入する

   ```latex
   \begin{figure}[tbp]
   \centering
   \includegraphics[width=0.9\linewidth]{図のファイル名（拡張子なし）}
   \caption{キャプション}
   \label{fig:ラベル名}
   \end{figure}
   ```

5. 参考文献は `chapters/99_references.tex` に直接追記する（または `references.bib` + `\bibliography{}` を使う）

6. PDFを生成する

   ```bash
   cd 卒論フォーマット
   bash build.sh
   ```

   または

   ```bash
   cd 卒論フォーマット
   latexmk -lualatex main.tex
   ```

   → `main.pdf` が生成される

### 論文様式の仕様（my_bthesis.cls）

| 項目 | 設定値 |
|------|--------|
| フォントサイズ | 12pt |
| 余白（左/右/上/下） | 30mm / 20mm / 25mm / 30mm |
| 本文：文字数/行数 | 30文字/行、30行/ページ |
| 要旨：文字数/行数 | 40文字/行、45行/ページ |
| 章番号形式 | 第1章、第2章 … |

---

## 2. 既存の卒業論文を再ビルド（thesis_build.sh）

リポジトリ内の `thesis/` フォルダにある論文を再コンパイルしてPDFを更新する。

```bash
cd /path/to/sotsuron_crossdomain_research_repo/thesis
bash /Users/h-torii4649/Desktop/PDF化プログラム/thesis_build.sh
```

または `thesis/` フォルダ内で直接実行：

```bash
cd ~/sotsuron_crossdomain_research_repo/thesis
bash build.sh
```

→ `thesis/main.pdf` が更新される

---

## 3. 研究計画書PDFを生成（research_plan_build.sh）

研究計画書のLaTeXソース（`research_plan_latex/`）からPDFを生成する。  
**tectonic** というコンパイラを使用。

```bash
# tectonic のインストール（未インストールの場合）
brew install tectonic

# 研究計画書フォルダ内で実行
cd ~/sotsuron_crossdomain_research_repo/research_plan_latex
bash /Users/h-torii4649/Desktop/PDF化プログラム/research_plan_build.sh
```

→ `research_plan_latex/main.pdf` が生成される

---

## 4. 論文の図をPDF/PNGで生成

### 方法A：全図を一括生成（generate_all_thesis_artifacts.py）

```bash
cd ~/sotsuron_crossdomain_research_repo
python3 /Users/h-torii4649/Desktop/PDF化プログラム/generate_all_thesis_artifacts.py
```

### 方法B：図生成スクリプト本体を直接実行（27_generate_thesis_figures_tables.py）

```bash
cd ~/sotsuron_crossdomain_research_repo
python3 pipeline/src/27_generate_thesis_figures_tables.py
```

生成される図（PNG + PDF）：

| ファイル名 | 内容 |
|-----------|------|
| `framework_overview` | 研究全体の枠組み |
| `method_pipeline` | 提案手法の処理フロー |
| `solution_type_quadrant` | 候補タイプの概念図（2軸） |
| `experiment1_pipeline` | 実験1の処理フロー |
| `experiment1_unet_trend` | U-Netの年次出現傾向 |
| `experiment1_baseline_comparison` | 実験1ベースライン比較 |
| `experiment2_pipeline` | 実験2の処理フロー |
| `experiment2_label_distribution` | 実験2 評価ラベル分布 |
| `experiment2_cluster_distribution` | 実験2 クラスタ別ラベル分布 |
| `experiment2_fulltext_overlap` | 提案手法とベースラインの重複 |

出力先：`pipeline/outputs/thesis_artifacts/figures/`

### 必要なPythonパッケージ

```bash
pip install matplotlib pandas numpy seaborn
```

---

## 5. スライド（Marp）のPDF変換

プレゼン用スライド `presentation/slides.md` をPDFに変換するには以下のコマンドを使用：

```bash
cd ~/sotsuron_crossdomain_research_repo
npx @marp-team/marp-cli presentation/slides.md --pdf --output presentation/slides.pdf
```

`node_modules/` が存在しない場合は先に `npm install` を実行してください。

---

## トラブルシューティング

| 症状 | 対処 |
|------|------|
| `lualatex: command not found` | TeX Live（MacTeX）をインストール： `brew install --cask mactex` |
| `tectonic: command not found` | `brew install tectonic` |
| 日本語が文字化けする | LuaLaTeX（`lualatex`）または `latexmk -lualatex` を使用してください |
| 図が見つからないエラー | `figures/` フォルダを作成し画像を配置してください |
| Python図生成でエラー | `pip install matplotlib pandas numpy seaborn` を実行してください |
# PDF-
