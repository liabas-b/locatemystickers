require 'spec_helper'

describe "tags/new" do
  before(:each) do
    assign(:tag, stub_model(Tag,
      :key => "MyString",
      :times_used => 1,
      :popularity => 1.5,
      :color => "MyString",
      :forbidden => false,
      :scope => "MyString"
    ).as_new_record)
  end

  it "renders new tag form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tags_path, :method => "post" do
      assert_select "input#tag_key", :name => "tag[key]"
      assert_select "input#tag_times_used", :name => "tag[times_used]"
      assert_select "input#tag_popularity", :name => "tag[popularity]"
      assert_select "input#tag_color", :name => "tag[color]"
      assert_select "input#tag_forbidden", :name => "tag[forbidden]"
      assert_select "input#tag_scope", :name => "tag[scope]"
    end
  end
end
