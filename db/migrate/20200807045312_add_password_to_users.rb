##『rails g migration add_password_to_users』をターミナルで実行し、作成されたファイル。
##Userデータベースに、パスワードを入力できる列を追加した。
class AddPasswordToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :password, :string##add_column :テーブル名, :カラム名, :データ型を指定し、Userのdbにパスワードが入力できる列を作成した。
  end
end

##データベースに『rails db:migrate』と実行すると、Useのデータベースにpasswordの列が追加される。
##『rails console』を実行することで、passwordの列にも値を代入することができる。
