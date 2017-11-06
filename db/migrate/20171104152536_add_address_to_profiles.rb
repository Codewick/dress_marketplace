class AddAddressToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :address, :string
  end
end
