class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :body, null: false
      t.datetime :send_at, null: false
      t.references :user, null: false
      t.references :channel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
