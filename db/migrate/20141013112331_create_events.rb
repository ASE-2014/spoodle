class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.integer :owner_id
      t.integer :definitive_date_id
      t.datetime :deadline
      t.timestamps
    end
  end
end
