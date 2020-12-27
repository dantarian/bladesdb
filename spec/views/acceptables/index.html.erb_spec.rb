require 'rails_helper'

RSpec.describe "acceptables/index", type: :view do
  before(:each) do
    assign(:acceptables, [
      Acceptable.create!(
        :type => "Type",
        :text => "MyText",
        :version => 1
      ),
      Acceptable.create!(
        :type => "Type",
        :text => "MyText",
        :version => 1
      )
    ])
  end

  it "renders a list of acceptables" do
    render
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
