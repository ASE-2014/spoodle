class AddCyberCoachToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cyber_coach_username, :string
    add_column :users, :cyber_coach_password, :string
  end
end
