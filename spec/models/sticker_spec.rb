# == Schema Information
#
# Table name: stickers
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  sticker_type_id :integer          default(1)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#  version         :integer          default(0)
#  is_active       :boolean          default(FALSE)
#  code            :string(255)
#  text            :string(255)
#

require 'spec_helper'

describe Sticker do

  let(:user) { FactoryGirl.create(:user) }
  before do
    @sticker = FactoryGirl.create(:sticker)
  end

  subject { @sticker }

  it { should respond_to(:name) }
  it { should respond_to(:user_id) }

	it { should be_valid }

  describe "when user_id is not present" do
    before { @sticker.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank name" do
    before { @sticker.name = " " }
    it { should_not be_valid }
  end

  describe "with name that is too long" do
    before { @sticker.name = "a" * 141 }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Sticker.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
end
