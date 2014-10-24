class CreateApiBases < ActiveRecord::Migration
  def change
    create_table :api_bases do |t|

      t.timestamps
    end
  end
end
