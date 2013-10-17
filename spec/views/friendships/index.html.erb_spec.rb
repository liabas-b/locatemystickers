require 'spec_helper'

describe "friendships/index" do
  before(:each) do
    assign(:friendships, [
      stub_model(Friendship),
      stub_model(Friendship)
    ])
  end

  it "renders a list of friendships" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
