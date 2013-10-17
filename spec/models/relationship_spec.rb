# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  owner_id    :integer
#  sticker_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Relationship do

  let(:shared_sticker) { FactoryGirl.create(:sticker) }
  let(:follower) { FactoryGirl.create(:user) }
  let(:owner) { FactoryGirl.create(:user) }
  let(:relationship) { follower.relationships.build(owner_id: owner.id, sticker_id: shared_sticker.id) }

  subject { relationship }

  it { should be_valid }

  describe "when owner id is not present" do
    before { relationship.owner_id = nil }
    it { should_not be_valid }
  end

  describe "when follower id is not present" do
    before { relationship.follower_id = nil }
    it { should_not be_valid }
  end

  describe "when sticker id is not present" do
    before { relationship.sticker_id = nil }
    it { should_not be_valid }
  end
end
