#routing→controller→viewのcontrollerの設定
#home_controllerを表示している
#controllerを経由してviewを表示する
#「rails generate controller home top」を実行したとき、
#「home_controller.rb」というコントローラのファイルが作成され、ファイルの中に「topメソッド」が追加される。
#コントローラ内のメソッドを「アクション」と呼ぶ。
#アクションは、コントローラと同じ名前のビューフォルダから、アクションと同じ名前のHTMLファイルを探してブラウザに返します。(今回だとtop)
class HomeController < ApplicationController
  before_action :forbid_login_user, {only: [:top]}##onlyの中ではアクションを指定する。

  def top#def~endの部分でtopアクション
  end

  def about#def~endの部分でaboutアクション
  end
end

#「rails new アプリケーション名」でtweet_appが作成でき、ファイルが自動的に作成されていく。
#「rails server」で検索可能になる
