require "spec_helper"

describe PousseMailer, focus: true do
  context 'When a location is created' do
    let(:user) { FactoryGirl.create :user, :with_stickers }

    it 'sends a new location mail' do
      user.stickers.first.locations.first
      ActionMailer::Base.deliveries.map(&:to).should == [[user.email], ['everybody']]
      ActionMailer::Base.deliveries.count.should == 2 # 1 for the user, 1 for the location
    end
  end
end
