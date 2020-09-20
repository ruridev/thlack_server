class AddIndexToChannelUsers < ActiveRecord::Migration[6.0]
  def change
    add_index :channel_users, %i[channel_id user_id], unique: true
  end
end
