require 'spec_helper'

describe "messages/index" do
  before(:each) do
    assign(:messages, [
      stub_model(Message,
        :user_id => 1,
        :from_user_id => 2,
        :subject => "Subject",
        :content => "Content"
      ),
      stub_model(Message,
        :user_id => 1,
        :from_user_id => 2,
        :subject => "Subject",
        :content => "Content"
      )
    ])
  end

  it "renders a list of messages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
    assert_select "tr>td", :text => "Content".to_s, :count => 2
  end
end
