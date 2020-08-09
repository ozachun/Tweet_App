##『rails g migration add_image_name_to_users』をtermnalで実行すると、以下のファイルがdb_migrateに作成された。
##これによって、Userのデータベースに,add_image_name_to_usersというデータ列を追加することができる。
class AddImageNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image_name, :string ##add_column :テーブル名, :カラム名, :データ型」と記載することで、新たな列をデータベースに追加することができる。
    ##今までは、rails g model　〜〜で後からデータベースの列を記入することはなかったが、新たに追加したい時は、この方法を使う。
    ##最後に、データベースに列を追加するためにターミナルで『rails db:migrate』を実行する。
  end
end
