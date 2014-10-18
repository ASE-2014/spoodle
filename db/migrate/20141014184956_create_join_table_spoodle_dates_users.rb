class CreateJoinTableSpoodleDatesUsers < ActiveRecord::Migration
  def change
    create_join_table :spoodle_dates, :users do |t|
       t.index [:spoodle_date_id, :user_id]
       t.index [:user_id, :spoodle_date_id]
    end
  end
end
