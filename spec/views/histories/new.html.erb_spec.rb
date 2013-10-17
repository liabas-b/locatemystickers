require 'spec_helper'

describe "histories/new" do
  before(:each) do
    assign(:history, stub_model(History,
      :model_id => 1,
      :operation => "MyString",
      :user_id => 1,
      :sticker_id => 1,
      :location_id => 1
    ).as_new_record)
  end

  it "renders new history form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => histories_path, :method => "post" do
      assert_select "input#history_model_id", :name => "history[model_id]"
      assert_select "input#history_operation", :name => "history[operation]"
      assert_select "input#history_user_id", :name => "history[user_id]"
      assert_select "input#history_sticker_id", :name => "history[sticker_id]"
      assert_select "input#history_location_id", :name => "history[location_id]"
    end
  end
end
