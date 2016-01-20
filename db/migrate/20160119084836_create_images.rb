class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :title
      t.text :url
      t.references :recipe, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
