class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.string :link_name
      t.string :url
      t.integer :link_type, default: 0
      t.datetime :expires_at
      t.string :link_password
      t.string :unique_token

      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
