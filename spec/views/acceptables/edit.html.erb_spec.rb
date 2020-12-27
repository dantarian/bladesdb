require 'rails_helper'

RSpec.describe "acceptables/edit", type: :view do
  before(:each) do
    @acceptable = assign(:acceptable, Acceptable.create!(
      :type => "",
      :text => "MyText",
      :version => 1
    ))
  end

  it "renders the edit acceptable form" do
    render

    assert_select "form[action=?][method=?]", acceptable_path(@acceptable), "post" do

      assert_select "input#acceptable_type[name=?]", "acceptable[type]"

      assert_select "textarea#acceptable_text[name=?]", "acceptable[text]"

      assert_select "input#acceptable_version[name=?]", "acceptable[version]"
    end
  end
end
