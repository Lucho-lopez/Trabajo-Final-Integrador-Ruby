class CreateVisitInfos < ActiveRecord::Migration[7.1]
  def change
    create_table :visit_infos do |t|
      t.string :ip_address
      t.datetime :visited_at

      t.references :link, foreign_key: true
      t.timestamps
    end
  end
end
