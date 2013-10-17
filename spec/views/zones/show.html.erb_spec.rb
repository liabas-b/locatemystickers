require 'spec_helper'

describe "zones/show" do
  before(:each) do
    @zone = assign(:zone, stub_model(Zone,
      :name => "Name",
      :description => "Description",
      :alert_level => 1,
      :alerts_on_enter => 2,
      :alerts_on_exit => 3,
      :sticker_id => 4,
      :colour => "Colour"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Description/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/Colour/)
  end
end
