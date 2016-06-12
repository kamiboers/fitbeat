class CreateFitbitCredentials < ActiveRecord::Migration
  def change
    create_table :fitbit_credentials do |t|
      t.string :uid
      t.string :token
      t.string :avatar_url
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
