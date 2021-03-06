class CreateChannels < ActiveRecord::Migration[6.0]
  def change
    create_table :channels do |t|
      t.string :name, null: false
      t.references :workspace, null: true, foreign_key: true

      t.timestamps
    end
  end
end
