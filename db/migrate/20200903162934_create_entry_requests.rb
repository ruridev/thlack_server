class CreateEntryRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :entry_requests do |t|
      t.references :workspace, null: false, foreign_key: true
      t.string :email, null: false, foreign_key: true
      t.integer :sender_user_id, null: true
      t.datetime :send_at, null: false

      t.timestamps
    end
  end
end