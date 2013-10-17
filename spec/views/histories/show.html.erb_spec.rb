require 'spec_helper'

describe "histories/show" do
  before(:each) do
    @history = assign(:history, stub_model(History,
      :model_id => 1,
      :operation => "Operation",
      :user_id => 2,
      :sticker_id => 3,
      :location_id => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Operation/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
  end
end
