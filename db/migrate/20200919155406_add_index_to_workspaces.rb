class AddIndexToWorkspaces < ActiveRecord::Migration[6.0]
  def change
    add_index :workspaces, %i[name], unique: true
  end
end
