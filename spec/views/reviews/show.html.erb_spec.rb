require 'rails_helper'

RSpec.describe "reviews/show", type: :view do
  before(:each) do
    @review = assign(:review, Review.create!(
      :content => "Content",
      :user => nil,
      :item => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Content/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
