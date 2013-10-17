# == Schema Information
#
# Table name: sticker_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  icon       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class StickerType < ActiveRecord::Base
  attr_accessible :name, :icon

  validates :name, presence: true, length: { maximum: 140 }
  validates :icon, presence: true, length: { maximum: 140 }
end
