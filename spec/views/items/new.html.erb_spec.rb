require 'rails_helper'

RSpec.describe "items/new", type: :view do
  before(:each) do
    assign(:item, Item.new(
      :name => "MyString",
      :price => 1.5,
      :description => "MyString",
      :category => "MyString",
      :image_data => "MyText",
      :user => nil
    ))
  end

  it "renders new item form" do
    render

    assert_select "form[action=?][method=?]", items_path, "post" do

      assert_select "input[name=?]", "item[name]"

      assert_select "input[name=?]", "item[price]"

      assert_select "input[name=?]", "item[description]"

      assert_select "input[name=?]", "item[category]"

      assert_select "textarea[name=?]", "item[image_data]"

      assert_select "input[name=?]", "item[user_id]"
    end
  end
end
