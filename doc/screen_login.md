You are a YAML generator.
I will provide all inputs in Japanese, but you must output ONLY valid YAML in English.

The YAML must strictly follow the format under "OUTPUT FORMAT".
Translate all Japanese descriptions into natural English suitable for UI generation prompts.

================================
# INPUT：個別画面設計書
================================

[1] プロジェクト名
iOS 塾マネアプリ

[2] モデルID
gemini-3-pro-image-preview

[3] 出力ディレクトリ
outputs/ios_app

[4] UIセット名
ios_ui_basic_set

[5] 画面数
1

[6] 画面定義（各画面の役割・レイアウト・構成要素）

■ 画面概要
- 画面名：
  ログイン画面
- 機能概要：
  メールアドレス・パスワードを入力し、認証APIを呼び出してログイン認証を行う。認証成功後、ユーザーのロールに応じたトップ画面へ遷移する。
- 利用ユーザ：
  管理者 / 講師 / 受付

■ レイアウト構成
- 上部：アプリロゴ＋アプリ名
- 中央：メールアドレス入力 / パスワード入力 / エラーメッセージ
- 下部：ログインボタン
- 最下部：バージョン表示（vX.Y.Z）

■ 共通パーツ
- ロゴ画像（塾マネ）
- 共通フォームスタイル（iOS/Android共通）

■ 画面レイアウト（イメージ）
┌──────────────────────────────────┐
│                                  │
│           （ ロ ゴ 画 像 ）          │
│        ★   JukuMane（塾マネ）   ★     │
│                                  │
│──────────────────────────────────│

│  メールアドレス                                      │
│  [ example@mail.com                           ]      │

│  パスワード                                          │
│  [ ●●●●●●●●●●●●●●●●●● ]   👁（表示切替）        │

│  （エラーメッセージ：必要時のみ表示）               │
│  例：メールアドレスまたはパスワードが違います        │

│                                                      │
│             [  ロ グ イ ン  ボ タ ン  ]             │
│                                                      │

│──────────────────────────────────│
│                     v1.0.0                         │
└──────────────────────────────────┘

■ 一覧表示（該当する場合）
本画面は一覧表示を持たないため **対象外**。

■ 画面項目定義  

| No | 項目名 | 物理名(ID) | UIタイプ | 必須 | 桁数/型 | 初期値 | 参照元/保存先 | 備考/制約 |
| :-- | :-- | :-- | :-- | :--: | :-- | :-- | :-- | :-- |
| 1 | ロゴ画像 | `img_logo` | Image | - | PNG/SVG | ロゴ画像 | - | 固定表示 |
| 2 | アプリ名ラベル | `lbl_app_title` | Text | - | 文字列 | 塾マネ | - | 固定文言 |
| 3 | メールアドレスラベル | `lbl_email` | Text | - | 文字列 | メールアドレス | - | - |
| 4 | メールアドレス入力 | `txt_email` | TextField | ○ | 最大255文字 | 空 | Users.email | メール形式チェック |
| 5 | パスワードラベル | `lbl_password` | Text | - | 文字列 | パスワード | - | - |
| 6 | パスワード入力 | `txt_password` | TextField(Secure) | ○ | 最大64文字 | 空 | Users.password_hash | 表示/非表示切替あり |
| 7 | 表示切替ボタン | `btn_toggle_password_visibility` | IconButton | - | Boolean | false | - | パスワードの可視化 |
| 8 | エラーメッセージ | `lbl_error_message` | Text | - | 文字列 | 非表示 | - | バリデーション/APIエラー表示 |
| 9 | ログインボタン | `btn_login` | Button | - | - | ログイン | /auth/login | 入力チェック後にAPI送信 |
| 10 | ローディング | `prog_loading` | ProgressIndicator | - | - | 非表示 | - | API呼び出し中表示 |
| 11 | バージョン情報 | `lbl_app_version` | Text | - | 文字列 | vX.Y.Z | アプリビルド情報 | 固定表示 |

■ 入出力一覧

| 種別 | データソース名 | 説明 |
| :--- | :--- | :--- |
| **Input** | `/auth/me`（任意） | 自動ログイン（トークン有効確認） |
| **Output** | `/auth/login` | メール/パスワードによる認証API呼び出し。ログイン成功時にJWTとユーザー情報を取得。 |

[7] プラットフォーム
ios

[8] 使用デバイス
iphone-16

[9] screen_type
login

[10] デザイン説明
Material3ベースに簡単に使用できるUI

[11] カラーパレット（推定）
Primary Blue：#0D3B66 付近（濃いネイビーブルー）
Light Gray / Background：#F7F8FA
Card White：#FFFFFF
Text Dark：#1B1B1D
Text Secondary：#6F6F73
Accent Colors（ステータス）
Present：ネイビー系 + 青アイコン
Late：オレンジ #F4A340
Absent：赤 #E65A50
Neutral icon background：淡い色の円形背景

[12] フォント（iOS標準を想定）
SF Pro Text / SF Pro Display
見出し：Bold
本文：Regular / Medium
小ラベル：12–14pt

[13] UI コンポーネントの特徴
角丸：12〜16px
カード影：ごく薄いシャドウ（iOS標準のモダンカード）
アイコン：線幅2pxのシンプルアイコン
ボタン：丸めの強い角丸（ピル型）
下部タブバー：2タブ、アイコン＋ラベル
余白：上下20〜24px、左右16px程度の広めレイアウト

====================================================================
OUTPUT RULES
====================================================================
1. Output ONLY valid YAML. No explanation.
2. Translate all Japanese descriptions into English.
3. Incorporate [11]～[16] into the prompt in a structured English paragraph.
4. For multi-screen: begin prompt with  
   "Create a horizontal layout showing <N> screens side by side:"
5. Maintain indentation exactly as in OUTPUT FORMAT.
6. Do NOT add comments (#).


====================================================================
OUTPUT FORMAT
====================================================================

version: 1
project:
name: <translated or original name>
model:
id: <input[2]>
output:
dir: <input[3]>

images:
- name: <input[4]>
  prompt: |
  Create a horizontal layout showing <input[5]> screens side by side:
  <translated screen descriptions from input[6]>

  Style details:
    - Base reference app: <translated input[11]>
    - Color theme: accent <input[12].accent>, background <input[12].background>, card <input[12].card>, text <input[12].text>, neutral <input[12].neutral>
    - Typography: font <input[13].font>, title size <input[13].title size>, body size <input[13].body size>, weight <input[13].weight>
    - Component shape: radius <input[14].radius>, shadow <input[14].shadow>, button style <input[14].button style>, border <input[14].border>
    - Spacing system: base <input[15].base>, section <input[15].section>, grid <input[15].grid>, safe area <input[15].safe area>
    - Aspect ratios: card <input[16].card>, feed <input[16].feed>, hero <input[16].hero>, thumbnail <input[16].thumbnail>

  Frame: Auto-adjust based on device and platform.
  asset:
  enabled: true
  type: screen
  screen:
  platform: <input[7]>
  devices: [<input[8]>]
  screen_type: <input[9]>
  description: "<translated input[10]>"

====================================================================
END
====================================================================
