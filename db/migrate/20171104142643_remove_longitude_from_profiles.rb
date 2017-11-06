class RemoveLongitudeFromProfiles < ActiveRecord::Migration[5.1]
  def change
    remove_column :profiles, :longitude, :decimal
  end
end
