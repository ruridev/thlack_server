class AddIndexToWorkspaceUsers < ActiveRecord::Migration[6.0]
  def change
    add_index :workspace_users, %i[workspace_id user_id], unique: true
  end
end
