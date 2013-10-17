require 'spec_helper'

describe "friendships/edit" do
  before(:each) do
    @friendship = assign(:friendship, stub_model(Friendship))
  end

  it "renders the edit friendship form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => friendships_path(@friendship), :method => "post" do
    end
  end
end
