require 'spec_helper'

describe "locations/index" do
  before(:each) do
    assign(:locations, [
      stub_model(Location,
        :id_sticker => "9.99",
        :latitude => "9.99",
        :longitude => "9.99"
      ),
      stub_model(Location,
        :id_sticker => "9.99",
        :latitude => "9.99",
        :longitude => "9.99"
      )
    ])
  end

  it "renders a list of locations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
