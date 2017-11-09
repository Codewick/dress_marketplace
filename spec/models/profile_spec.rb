require 'rails_helper'

RSpec.describe Profile, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it"is invalid without a firstname" do
    user=Profile.new(first_name:nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it"is invalid without a address" do
    user=Profile.new(address:nil)
    user.valid?
    expect(user.errors[:address]).to include("can't be blank")
  end


end
