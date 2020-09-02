class CreateWorkspaceOwners < ActiveRecord::Migration[6.0]
  def change
    create_table :workspace_owners do |t|
      t.references :user, null: false, foreign_key: true
      t.references :workspace, null: false, foreign_key: true

      t.timestamps
    end
  end
end
