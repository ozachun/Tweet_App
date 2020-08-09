##『raisl g controller users index』 を実行すると作成された。
##usersコントローラーでは、ユーザーの個人情報を管理するコントローラーとして、運用する。
class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}##users/indexとshowとeditとupdateは、authenticate_userの処理(ログイン)を行った後に実行できる。
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}##ログイン中、users/newとcreateとlogin_formとloginを検索しても表示できないようになる。
  before_action :ensure_correct_user, {only: [:edit, :update]}
  
  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      image_name: "default_user.png",##画像が表示されない。おそらく、初期画像を登録する前から登録していたユーザーに適用されていない。
      password: params[:password]
    )##新規登録時、new()内で、name,emailの入力内容、image_nameで"default_user.png"を表示する。
     if @user.save
       session[:user_id] = @user.id
       flash[:notice] = "ユーザー登録が完了しました"##flash[:notice]はapplication.htmlに共通レアアウトとして記載されている。詳細はapplication.htmlを参照。
       redirect_to("/users/#{@user.id}")
     else
       render("users/new")##renderでルーティングを経由せずに直接viewを表示している。これによって、入力した初期値を消さずにそのまま表示できる。
     end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

   def update
     @user = User.find_by(id: params[:id])
     @user.name = params[:name]#edit.htmlで指定した。name属性の"name"の内容を取得している。詳細はusers/edit.htmlを参照。
     @user.email = params[:email]#edit.htmlで指定した。name属性の"email"の内容を取得している。詳細はusers/edit.htmlを参照。

     if params[:image]##画像を保存する場合の条件文
      @user.image_name = "#{@user.id}.jpg"##入力内容から取得
      image = params[:image]##name属性の"image"をimageに代入
      File.binwrite("public/user_images/#{@user.image_name}", image.read)##画像を保存することは、新たなファイルを保存することなので、Fileクラスを使う。画像を保存するので、writeではなくbinwriteを使用。第一引数：保存先、第二引数：画像を読み込むための変数
     end

     if @user.save
       flash[:notice] = "ユーザー情報を編集しました"#application.htmlで共通レイアウトとして指定されたflashを指定している。
       redirect_to("/users/#{@user.id}")
     else
       render("users/edit")##直接viewを指定するので、HTMLファイルの名前をかく！
     end
   end

   def login_form
   end
   ##ログイン画面を表示するコントローラー

   def login
     @user = User.find_by(email: params[:email],password: params[:password])
     if @user
       session[:user_id] = @user.id#ログインに成功した場合、その後もユーザー情報を保持し続けるためにsessionを使う。『 session[:キー名]＝ 値 』で記入する。
       flash[:notice] = "ログインしました"
       redirect_to("/users/index")
     else
       @error_message = "メールアドレスまたはパスワードが間違っています"
       @email = params[:email]#間違った入力初期値をそのままlogin_formで表示するため@emailに代入している。
       @password = params[:password]#間違った入力期値をそのままlogin_formで表示するため@passwordに代入している。
       render("users/login_form")
     end
   end
   ##ログインできるかできないかを判定するコントローラー

   def logout
     session[:user_id] = nil
     flash[:notice] = "ログアウトしました"
     redirect_to("/login")
   end

   def ensure_correct_user
     if @current_user.id != params[:id].to_i##現在ログイン中のID と 検索URLにある値が等しいかをチェックしている。
       flash[:notice] = "権限がありません"
       redirect_to("/posts/index")
     end
   end
end
