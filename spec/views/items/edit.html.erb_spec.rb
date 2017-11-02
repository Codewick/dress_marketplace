require 'rails_helper'

RSpec.describe "items/edit", type: :view do
  before(:each) do
    @item = assign(:item, Item.create!(
      :name => "MyString",
      :price => 1.5,
      :description => "MyString",
      :category => "MyString",
      :image_data => "MyText",
      :user => nil
    ))
  end

  it "renders the edit item form" do
    render

    assert_select "form[action=?][method=?]", item_path(@item), "post" do

      assert_select "input[name=?]", "item[name]"

      assert_select "input[name=?]", "item[price]"

      assert_select "input[name=?]", "item[description]"

      assert_select "input[name=?]", "item[category]"

      assert_select "textarea[name=?]", "item[image_data]"

      assert_select "input[name=?]", "item[user_id]"
    end
  end
end
