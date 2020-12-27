require 'rails_helper'

RSpec.describe "acceptables/new", type: :view do
  before(:each) do
    assign(:acceptable, Acceptable.new(
      :type => "",
      :text => "MyText",
      :version => 1
    ))
  end

  it "renders new acceptable form" do
    render

    assert_select "form[action=?][method=?]", acceptables_path, "post" do

      assert_select "input#acceptable_type[name=?]", "acceptable[type]"

      assert_select "textarea#acceptable_text[name=?]", "acceptable[text]"

      assert_select "input#acceptable_version[name=?]", "acceptable[version]"
    end
  end
end
