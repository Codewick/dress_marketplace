class RemoveStreetFromProfiles < ActiveRecord::Migration[5.1]
  def change
    remove_column :profiles, :street, :string
  end
end
