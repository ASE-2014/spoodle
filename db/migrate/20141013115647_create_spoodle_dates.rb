class CreateSpoodleDates < ActiveRecord::Migration
  def change
    create_table :spoodle_dates do |t|
      t.datetime :from
      t.datetime :to
      t.references :event, index: true

      t.timestamps
    end
  end
end
