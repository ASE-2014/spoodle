class CreateRestUsers < ActiveRecord::Migration
  def change
    create_table :rest_users do |t|

      t.timestamps
    end
  end
end
