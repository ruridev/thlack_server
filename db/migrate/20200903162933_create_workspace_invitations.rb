class CreateWorkspaceInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :workspace_invitations do |t|
      t.references :workspace, null: false, foreign_key: true
      t.integer :sender_user_id, null: false
      t.string :email, null: false, foreign_key: true
      t.integer :receiver_user_id, null: true
      t.integer :status, null: false

      t.timestamps
    end
  end
end
