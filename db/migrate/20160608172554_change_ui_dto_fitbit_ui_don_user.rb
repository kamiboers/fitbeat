class ChangeUiDtoFitbitUiDonUser < ActiveRecord::Migration
  def change
    rename_column :users, :uid, :fitbit_uid
  end
end
