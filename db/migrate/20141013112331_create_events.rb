class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.integer :owner_id
      t.integer :definitive_date_id
      t.integer :deadline_id
      t.timestamps
    end
  end
end
