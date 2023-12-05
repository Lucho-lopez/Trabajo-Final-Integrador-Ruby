class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.string :url
      t.string :link_type
      t.datetime :expires_at
      t.string :link_password
      t.string :unique_token

      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
