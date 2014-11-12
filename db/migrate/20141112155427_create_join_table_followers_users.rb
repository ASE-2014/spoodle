class CreateJoinTableFollowersUsers < ActiveRecord::Migration
  def change
    create_join_table :followers, :users do |t|
      t.index [:follower_id, :user_id]
      t.index [:user_id, :follower_id]
    end
  end
end
