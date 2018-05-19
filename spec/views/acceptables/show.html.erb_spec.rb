require 'rails_helper'

RSpec.describe "acceptables/show", type: :view do
  before(:each) do
    @acceptable = assign(:acceptable, Acceptable.create!(
      :type => "Type",
      :text => "MyText",
      :version => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
  end
end
