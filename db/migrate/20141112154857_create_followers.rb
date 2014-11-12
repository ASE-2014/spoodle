class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.datetime :datetime
      t.references :user, index: true

      t.timestamps
    end
  end
end
