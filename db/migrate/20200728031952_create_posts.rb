##akihironoMacBook:tweet_app akihiroozaki$ rails g model Post content:text をterminalで実行するとdb/migrateが作成され、その中にこのファイルが作成された。
class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :content

      t.timestamps
    end
  end
end
