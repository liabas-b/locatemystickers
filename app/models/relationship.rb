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

class Relationship < ActiveRecord::Base
  attr_accessible :follower_id, :owner_id, :sticker_id

  belongs_to :follower, class_name: "User"
  belongs_to :owner, class_name: "User"
  belongs_to :sticker

  validates :follower_id, presence: true
  validates :owner_id, presence: true
  validates :sticker_id, presence: true
end
