class CreateFriends < ActiveRecord::Migration[6.0]
  def change
    create_table :friends do |t|
      t.integer :subject_user_id, null: false
      t.integer :object_user_id, null: false

      t.timestamps
    end
  end
end
