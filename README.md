**Name**  
家計簿App

**動作環境**  
-Rails: 5.1.7  
-Ruby: 2.6.3  
-Chart.js  

**URL**  
https://kakeibo-apply.herokuapp.com/


**Overview**  
主な機能:  
-費目の入力・更新・削除・閲覧機能  
-カテゴリー・メモの記入機能  
-カレンダー機能  
-月時集計機能  

**Install**  
```
git clone https://github.com/opuoth/account_book
cd account_book
bundle install
```

データベースを設定します
```
rails db:migrate
rails db:seed
```

サーバーを下記コマンドで立てます
```
rails s
```

http://localhost:3000 に接続するとアプリが起動します