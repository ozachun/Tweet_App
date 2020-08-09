##rails g model User name:string email:string と記入しUser.rbが作成され、rails db:migrateとすると以下が作成された。
##データベースの列要素が表示され、nameとemailがある。
class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
