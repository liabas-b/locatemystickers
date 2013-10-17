require 'spec_helper'

describe "zones/index" do
  before(:each) do
    assign(:zones, [
      stub_model(Zone,
        :name => "Name",
        :description => "Description",
        :alert_level => 1,
        :alerts_on_enter => 2,
        :alerts_on_exit => 3,
        :sticker_id => 4,
        :colour => "Colour"
      ),
      stub_model(Zone,
        :name => "Name",
        :description => "Description",
        :alert_level => 1,
        :alerts_on_enter => 2,
        :alerts_on_exit => 3,
        :sticker_id => 4,
        :colour => "Colour"
      )
    ])
  end

  it "renders a list of zones" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Colour".to_s, :count => 2
  end
end
