###routing→controller→viewのcontrollerの設定
##posts_controllerを表示している
##「rails generate controller posts index」を実行し、作成した
##投稿に関することなので、posts_controllerを作成、home_controllerでも実行可能。
class PostsController < ApplicationController
  before_action :authenticate_user!##ここのルーティングがおかしいのかRoutingのerrorが出る
  ##posts_controller内では:authenticate_userという処理を実行してから以下の実行を行う。authenticate_userの内容はapplication.controller内で定義している。
　##before_action処理の結果、ログイン後でなければ以下のアクションを実行できなくなった。

  def index
  ##変数をviewファイルないで定義してきたが、railsではactionで定義することが一般的
  ##@...から始めることでactionで定義した変数をview(HTML)で使うことができる
   @posts = Post.all.order(created_at: :desc)##Post.allで表示し、投稿を作成日順（新しい順）に並び替えて@postに代入
  end

  def show
    #@id = params[:id]#params[:id]は、routingで設定したURLの「:id」の値を取得することができる。
    @post = Post.find_by(id: params[:id])
    #モデル名.find_by(特定の条件)今回は、id:カラムがroutingで設定したURLの「:id」の値を条件にして取得している。
  end
   ##投稿詳細確認のため「show」アクションを追加

   def new
     @post = Post.new
   end
   ##新規投稿画面作成のため「show」アクションを追加

   def create
      @post = Post.new(content: params[:content])##Postのデータベースに新規投稿内容を保存し、それを＠postとする。
      ##new.htmlのform_tag内にあるname="content"の内容条件にし、取得する。
      if @post.save ##新規投稿に成功したかどうかで、成功→投稿一覧へ 失敗→新規投稿ページに移動し、再度編集できるようになる。
        flash[:notice] = "投稿を作成しました"#投稿作成が成功した場合に投稿を作成しましたと表示することができる。
        ## application HTMLで共通レイアウトとして、flash[:notice]表示する。
        redirect_to("/posts/index")
      else
        render("posts/new")
      end
      ##createを実行したら自動で/posts/indexに移動する。
      ##つまり投稿ボタンを押したら自動で/posts/indexに移動する
   end
   ##新規投稿をDBに保存するため「create」アクションを追加
   def edit
     @post = Post.find_by(id: params[:id])
   end


   def update
     @post = Post.find_by(id: params[:id])##Postのデータベースからidを条件に投稿内容を取得
     @post.content = params[:content] ##paramas[:content]は、edit.html.erbのcontentを取得している。これで投稿内容をデータベースに保存でき、投稿内容が更新ができる。
     if @post.save
       flash[:notice] = "投稿を編集しました" ## 投稿に成功したときに『投稿を編集しました』というメッセージを定義するアクションを追加。
       ## application HTMLで共通レイアウトとして、flash[:notice]表示すると指定している。詳細はapplication.htmlを参照。
       redirect_to("/posts/index")
     else
       render("posts/edit")#render("フォルダ名/ファイル名")
       ##renderメソッドを用いることで、別のアクションを経由せずに、直接ビュー(posts/edit)を表示することができます。
       ##これで、投稿の保存が失敗した時に、失敗する直前の状態から再編集できる。(頑張って150文字入れたのに全部消えちゃったということがなくなる)
     end
   end
   ##投稿更新機能
   ##updateアクションを実行後、/posts/indexに移動する

   def destroy
     @post = Post.find_by(id: params[:id])
     @post.destroy
     flash[:notice] = "投稿を削除しました"##投稿を削除することを表示する。
     ## application HTMLで共通レイアウトとして、flash[:notice]表示する。
     redirect_to("/posts/index")#destroyアクションを実行すると、/posts/indexに自動で移動する。
     ##投稿削除機能
   end
end
