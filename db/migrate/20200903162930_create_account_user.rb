class CreateAccountUser < ActiveRecord::Migration[6.0]
  def change
    create_table :account_user do |t|
      t.references :user, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
