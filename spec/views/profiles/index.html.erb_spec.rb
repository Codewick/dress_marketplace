require 'rails_helper'

RSpec.describe "profiles/index", type: :view do
  before(:each) do
    assign(:profiles, [
      Profile.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :image_data => "MyText",
        :street => "Street",
        :city => "City",
        :state => "State",
        :post_code => 2,
        :longitude => "9.99",
        :latitude => "9.99"
      ),
      Profile.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :image_data => "MyText",
        :street => "Street",
        :city => "City",
        :state => "State",
        :post_code => 2,
        :longitude => "9.99",
        :latitude => "9.99"
      )
    ])
  end

  it "renders a list of profiles" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Street".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
