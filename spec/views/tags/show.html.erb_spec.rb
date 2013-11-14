require 'spec_helper'

describe "tags/show" do
  before(:each) do
    @tag = assign(:tag, stub_model(Tag,
      :key => "Key",
      :times_used => 1,
      :popularity => 1.5,
      :color => "Color",
      :forbidden => false,
      :scope => "Scope"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Key/)
    rendered.should match(/1/)
    rendered.should match(/1.5/)
    rendered.should match(/Color/)
    rendered.should match(/false/)
    rendered.should match(/Scope/)
  end
end
