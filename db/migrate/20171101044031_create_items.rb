class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.float :price
      t.string :description
      t.string :category
      t.text :image_data
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
