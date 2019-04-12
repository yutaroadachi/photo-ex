# アプリケーション名  
PHOTO EX  
<https://photo-ex.herokuapp.com>  
  
テストユーザーでログイン ※ログインしなくても一部機能は利用できます。  
Eメール   ：example@mail.com  
パスワード：password  
  
# 概要  
PHOTO EX（Photo Exhibition）はインターネット上の写真展です。  
  
# 機能一覧  
ユーザー認証機能（Facebook認証も実装） => gem：devise, omniauth, omniauth-facebook  
写真投稿機能（保存先はS3 bucketを使用） => gem：carrierwave  
ユーザーフォロー機能  
写真へのいいね機能  
写真へのコメント機能  
ページネーション機能 => gem：will_paginate  
ユーザー・写真検索機能 => gem：ransack  
日本語化 => gem：rails-i18n
  
# 使用している技術一覧  
言語 => Ruby  
フレームワーク => Ruby on Rails  
テストコード => RSpec  
データベース => PostgreSQL  
バージョン管理 => Git  
リポジトリ管理 => Bitbucket  
インフラ => Heroku

# 使用方法  
ヘッダーの右上の各アイコンをクリックすることで各機能の画面に遷移します。  

カメラのアイコン => ホーム/写真投稿画面※  
写真のアイコン => 写真一覧画面  
人のアイコン => 写真家一覧画面  
ハンバーガーメニュー => サインアップ/ログイン/マイページ※/設定※/ログアウト※  
  
※のついているボタン・画面はログインユーザーのみ表示されます。
