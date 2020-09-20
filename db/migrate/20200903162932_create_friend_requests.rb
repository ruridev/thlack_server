class CreateFriendRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :friend_requests do |t|
      t.integer :sender_user_id, null: false
      t.integer :receiver_user_id, null: false

      t.timestamps
    end
  end
end
