require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"


  it"is invalid without a firstname" do
    user=User.new(email:nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end
end
