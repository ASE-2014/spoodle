class CreateSpoodleDates < ActiveRecord::Migration
  def change
    create_table :spoodle_dates do |t|
      t.datetime :datetime
      t.references :event, index: true

      t.timestamps
    end
  end
end
