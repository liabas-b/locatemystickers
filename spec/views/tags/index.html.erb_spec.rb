require 'spec_helper'

describe "tags/index" do
  before(:each) do
    assign(:tags, [
      stub_model(Tag,
        :key => "Key",
        :times_used => 1,
        :popularity => 1.5,
        :color => "Color",
        :forbidden => false,
        :scope => "Scope"
      ),
      stub_model(Tag,
        :key => "Key",
        :times_used => 1,
        :popularity => 1.5,
        :color => "Color",
        :forbidden => false,
        :scope => "Scope"
      )
    ])
  end

  it "renders a list of tags" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Key".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "Color".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Scope".to_s, :count => 2
  end
end
