class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :friend_one_id, index: true
      t.integer :friend_two_id, index: true

      t.timestamps
    end
  end
end
