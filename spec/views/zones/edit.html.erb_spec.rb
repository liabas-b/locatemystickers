require 'spec_helper'

describe "zones/edit" do
  before(:each) do
    @zone = assign(:zone, stub_model(Zone,
      :name => "MyString",
      :description => "MyString",
      :alert_level => 1,
      :alerts_on_enter => 1,
      :alerts_on_exit => 1,
      :sticker_id => 1,
      :colour => "MyString"
    ))
  end

  it "renders the edit zone form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => zones_path(@zone), :method => "post" do
      assert_select "input#zone_name", :name => "zone[name]"
      assert_select "input#zone_description", :name => "zone[description]"
      assert_select "input#zone_alert_level", :name => "zone[alert_level]"
      assert_select "input#zone_alerts_on_enter", :name => "zone[alerts_on_enter]"
      assert_select "input#zone_alerts_on_exit", :name => "zone[alerts_on_exit]"
      assert_select "input#zone_sticker_id", :name => "zone[sticker_id]"
      assert_select "input#zone_colour", :name => "zone[colour]"
    end
  end
end
