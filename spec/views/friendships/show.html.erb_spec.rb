require 'spec_helper'

describe "friendships/show" do
  before(:each) do
    @friendship = assign(:friendship, stub_model(Friendship))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
