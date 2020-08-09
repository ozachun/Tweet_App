##rails g model User name:string email:string　で、データベースが作成できた。　Userのデータベースを保存する場合はUser.・・・から初めて記入する。
class User < ApplicationRecord
  validates :name ,{presence:true}##nameの保存条件に、空の投稿を禁止した。
  validates :email ,{presence:true,uniqueness:true} ##emailの保存条件として空の投稿の禁止、重複の禁止をした。
  validates :password ,{presence:true}##passwordが空欄のままを禁止した。
end

##post.rb同様に、データベースにターミナルからデータベースに保存・確認する方法として、『raisl console』を実行する。
##新たにユーザーをUserデータベースに追加する場合は、『user = User.new(name: "にんじゃわんこ", email: "wanko@prog-8.com")』と実行する。
##『user.save』でUserデータベースに保存できる。
