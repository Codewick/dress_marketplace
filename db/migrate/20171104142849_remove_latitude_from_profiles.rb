class RemoveLatitudeFromProfiles < ActiveRecord::Migration[5.1]
  def change
    remove_column :profiles, :latitude, :decimal
  end
end
