class ApplicationController < ActionController::Base
  ##全アクションで共通する処理をapplication/htmlで書く。
  before_action :set_current_user ##全アクションで共通する処理を『set_current_user』という名前にした。

  def set_current_user##set_current_userの処理内容を定義した。
   @current_user = User.find_by(id: session[:user_id])##application.htmlで使用するため、application.htmlで定義した。
  end

  def authenticate_user
    if @current_user == nil## set_current_userで定義した@current_userの情報がない場合、すなわちログインできていない場合の条件文
      flash[:notice] = "ログインが必要です"
      redirect_to("/login")
    end##if分のあとのend忘れない！！
  end

  def forbid_login_user ##ログインユーザーに対して、アクセス制限する
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to("/posts/index")
    end
  end
end
