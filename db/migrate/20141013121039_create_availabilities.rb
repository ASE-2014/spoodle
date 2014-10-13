class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.references :spoodle_date, index: true
      t.references :user, index: true
      t.references :event, index: true

      t.timestamps
    end
  end
end
