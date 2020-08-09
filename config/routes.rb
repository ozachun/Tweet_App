#routing→controller→viewのroutingの設定
#routing:送信されたURLに対して「どのコントローラの、どのアクション」で処理するかを決める「対応表」のこと
#ブラウザでURLを入力すると、ルーティングがURLを見て、適切なコントローラのアクションを呼び出します。
Rails.application.routes.draw do

  ##↓postsのルーティング↓
  get "posts/index" => "posts#index"
  #get "URL" => "コントローラー名#アクション名"で記載する
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  ##フォームの値を受け取る場合は「post」とすることに注意！！今回は、form_tagで指定したposts/createのURLを受け取っている。
  ##正確には、データベースの変更を行う場合postを使用する。
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"##データベースに変更を加えるのでpostを使うことに注意!!
  post "posts/:id/destroy" => "posts#destroy"
  ##↑postsのルーティング↑

  ##↓userのルーティング↓
  post "logout" => "users#logout"##ここではsessionの値を変更するのでpostを使う。そのため、application.htmlでログアウトのllink_toの第三引数は『method: :post』を指定する。
  get "login" => "users#login_form"##ログイン機能の追加
  post "login" => "users#login"##入力ホームを受け取る
  get "users/index" => "users#index"
  post "users/create" => "users#create"
  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update" ## "#"シャープを使ってコントローラーを指定する！！
  get "users/:id" => "users#show"
  get "signup" => "users#new"
  ##↑userのルーティング↑

  get "/" => "home#top"
  get "about" => "home#about"
  #aboutのページを作成するために、routing→controller→viewのroutingの設定
end
