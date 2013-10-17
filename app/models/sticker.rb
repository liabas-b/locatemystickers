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
#  color           :string(255)
#

class Sticker < ActiveRecord::Base
  include ApplicationHelper
  attr_accessible :name, :user, :locations, :version, :sticker_type_id, :color, :code, :text, :is_active, :created_at, :updated_at, :user_id

  belongs_to :user
  has_many :locations, dependent: :destroy
  has_many :zones, dependent: :destroy
  has_many :histories

  validates :name, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

	default_scope order: 'stickers.created_at DESC'

  before_save {
    if (self.code.nil? || self.code == "")
      self.update_attributes(code: Digest::MD5::hexdigest(self.name + self.user_id.to_s))
    end
  }

  # NOTIFICATION TRIGGERS
  after_create do |sticker|
    sticker.histories.create!(subject: "sticker", operation: "created")
  end
  after_update do |sticker|
    sticker.histories.create!(subject: "sticker", operation: "updated")
  end
  before_destroy do |sticker|
    sticker.histories.create!(subject: "sticker", operation: "deleted")
  end

  def self.search(search, column = 'name')
    if search
      if column == 'id' || column == 'sticker_type_id' || column == 'user_id' || column == 'version' || column == 'is_active'
        where("stickers.#{column} = ?", "#{search}")
      else
        where("stickers.#{column} LIKE ?", "%#{search}%")
      end
    else
      scoped
    end
  end

  def last_location
    self.locations.last unless self.locations.empty?
  end

  def last_location_address
    if self.last_location && self.last_location.address && !self.last_location.address.empty?
      self.locations.last.address
    else
      'Unknown'
    end
  end

  def update_locations
    new_locations = get_ss_sticker_locations(self.code)
    new_locations.each do |location|
      Location.create!(:latitude => location.latitude,
                        :longitude => location.longitude,
                        :sticker_id => location.sticker_id,
                        :created_at => location.created_at,
                        :updated_at => location.updated_at)
      delete_ss_sticker_location(location.id)
    end
  end

	private

	def increment_version
		self.version += 1

		if (self.user.compteur.nil?)
			self.user.compteur = 0
		else
			self.user.compteur += 1
		end
	end

end
