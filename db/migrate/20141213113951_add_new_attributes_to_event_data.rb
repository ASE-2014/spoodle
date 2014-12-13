class AddNewAttributesToEventData < ActiveRecord::Migration
  def change
    add_column :event_datas, :elevation_gain, :integer
    add_column :event_datas, :rounds, :integer
    add_column :event_datas, :party_1_red_cards, :integer
    add_column :event_datas, :party_2_red_cards, :integer
    add_column :event_datas, :party_1_yellow_cards, :integer
    add_column :event_datas, :party_2_yellow_cards, :integer
    add_column :event_datas, :party_1_penalties, :integer
    add_column :event_datas, :party_2_penalties, :integer
  end
end
