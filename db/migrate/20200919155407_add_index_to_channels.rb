class AddIndexToChannels < ActiveRecord::Migration[6.0]
  def change
    add_index :channels, %i[workspace_id name], unique: true
  end
end
