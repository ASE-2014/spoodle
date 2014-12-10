class AddSportsNameToEvents < ActiveRecord::Migration
  def change
    add_column :events, :sports_name, :string
  end
end
