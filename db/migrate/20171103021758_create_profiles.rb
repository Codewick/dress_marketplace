class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.text :image_data
      t.string :street
      t.string :city
      t.string :state
      t.integer :post_code
      t.decimal :longitude
      t.decimal :latitude

      t.timestamps
    end
  end
end
