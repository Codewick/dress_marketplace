class AddHasPaidToBookings < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :has_paid, :boolean
  end
end
