require 'spec_helper'

describe "histories/index" do
  before(:each) do
    assign(:histories, [
      stub_model(History,
        :model_id => 1,
        :operation => "Operation",
        :user_id => 2,
        :sticker_id => 3,
        :location_id => 4
      ),
      stub_model(History,
        :model_id => 1,
        :operation => "Operation",
        :user_id => 2,
        :sticker_id => 3,
        :location_id => 4
      )
    ])
  end

  it "renders a list of histories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Operation".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
