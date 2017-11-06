class AddAmountToBookings < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :amount, :float
  end
end
