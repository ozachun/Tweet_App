##rails g model Post content:textを入力すると作成された。rails g model テーブル名（単数形）　カラム名：データ型
##Postモデルのおかげで、postsテーブルが操作できる。
##postsテーブルにはid,content,created_at,update_atがある。content以外は自動生成される。
##「rails db:migrate」を実行し、マイグレーションファイルの内容をデータベースに反映させる。

class Post < ApplicationRecord
  validates :content ,{presence:true, length:{maximum: 140}}
  ##不正なデータがデータベースに保存されないように、データをチェックする仕組みのことをバリデーションといい不正な場合はデータベースに保存されない。
  ##validate ：検証するカラム名,{検証する内容,検証する内容,,,}今回は、カラム名contentが存在するかと文字数が最大140文字まで
  ##これで、新規投稿の内容(content)に何も入っていない場合、140文字を超える場合、保存されなくなる。
end

##データベースに投稿データを保存できるか確認するために、rails consoleを実行。
##postsテーブルが作成されたので、そこに投稿内容を追加することができる。
##ex) post = Post.new(content: "Hello world"） ##投稿内容を「Hello world」としている。
##ex) post.save ##postに代入した値を保存する
##ex) post.destroy ##postに代入した値を削除する
