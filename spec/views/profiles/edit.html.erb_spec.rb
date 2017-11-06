require 'rails_helper'

RSpec.describe "profiles/edit", type: :view do
  before(:each) do
    @profile = assign(:profile, Profile.create!(
      :first_name => "MyString",
      :last_name => "MyString",
      :image_data => "MyText",
      :street => "MyString",
      :city => "MyString",
      :state => "MyString",
      :post_code => 1,
      :longitude => "9.99",
      :latitude => "9.99"
    ))
  end

  it "renders the edit profile form" do
    render

    assert_select "form[action=?][method=?]", profile_path(@profile), "post" do

      assert_select "input[name=?]", "profile[first_name]"

      assert_select "input[name=?]", "profile[last_name]"

      assert_select "textarea[name=?]", "profile[image_data]"

      assert_select "input[name=?]", "profile[street]"

      assert_select "input[name=?]", "profile[city]"

      assert_select "input[name=?]", "profile[state]"

      assert_select "input[name=?]", "profile[post_code]"

      assert_select "input[name=?]", "profile[longitude]"

      assert_select "input[name=?]", "profile[latitude]"
    end
  end
end
