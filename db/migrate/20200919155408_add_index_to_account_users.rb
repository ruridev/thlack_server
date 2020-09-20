class AddIndexToAccountUsers < ActiveRecord::Migration[6.0]
  def change
    add_index :account_users, %i[account_id user_id], unique: true
  end
end
