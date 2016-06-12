class AddExpirationAndRefreshToFitbitCredential < ActiveRecord::Migration
  def change
    add_column :fitbit_credentials, :refresh_token, :string
    add_column :fitbit_credentials, :token_expiration, :string
  end
end
