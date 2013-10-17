require 'spec_helper'

describe "histories/edit" do
  before(:each) do
    @history = assign(:history, stub_model(History,
      :model_id => 1,
      :operation => "MyString",
      :user_id => 1,
      :sticker_id => 1,
      :location_id => 1
    ))
  end

  it "renders the edit history form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => histories_path(@history), :method => "post" do
      assert_select "input#history_model_id", :name => "history[model_id]"
      assert_select "input#history_operation", :name => "history[operation]"
      assert_select "input#history_user_id", :name => "history[user_id]"
      assert_select "input#history_sticker_id", :name => "history[sticker_id]"
      assert_select "input#history_location_id", :name => "history[location_id]"
    end
  end
end
