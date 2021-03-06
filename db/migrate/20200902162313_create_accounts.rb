class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :identifier, null: false
      t.string :type, null: false
      t.string :email, null: true
      t.string :password_digest, null: false
      t.integer :status, null: false

      t.timestamps
    end

    add_index :accounts, :identifier
    add_index :accounts, [:type, :identifier], unique: true
  end
end
