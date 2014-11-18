class CreateEventData < ActiveRecord::Migration
  def change
    create_table :event_data do |t|
      t.belongs_to :event, index: true
      t.integer :distance
      t.string :winner_name
      t.string :party_1_name
      t.string :party_2_name
      t.integer :score_1
      t.integer :score_2

      t.timestamps
    end
  end
end
