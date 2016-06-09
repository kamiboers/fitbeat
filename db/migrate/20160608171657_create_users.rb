class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :avatar_url
      t.string :uid
      t.string :fitbit_token
      t.string :spotify_uid
      t.string :spotify_token

      t.timestamps null: false
    end
  end
end
