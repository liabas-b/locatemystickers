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
	attr_accessible :name, :user, :locations, :version, :sticker_type_id, :color, :code, :text, :is_active, :created_at, :updated_at, :user_id, :last_location,
					:sticker_configuration

	belongs_to :user
	has_many :locations, dependent: :destroy
	has_many :zones, dependent: :destroy
	has_many :histories
	has_one :sticker_configuration

	validates :name, presence: true, length: { maximum: 140 }
	validates :user_id, presence: true

	default_scope order: 'stickers.created_at DESC'

	# Callbacks
	before_save :generate_code
	after_initialize :update_locations
	after_create :after_create_callback
	after_update :after_update_callback
	before_destroy :before_destroy_callback

	def self.search(search, column = 'name')
		if search
			if ['id', 'sticker_type_id' , 'user_id', 'is_active']. include?(column)
				where("stickers.#{column} = ?", "#{search}")
			else
				where("stickers.#{column} LIKE ?", "%#{search}%")
			end
		else
			scoped
		end
	end

	# Gets all missing locations that were stored on the stickers server
	def update_locations
		if self.code and not self.code.empty?
			new_locations = get_ss_sticker_locations(self.code)
			new_locations.each do |location|
				Location.create!( 
					latitude: location.latitude,
					longitude: location.longitude,
					sticker_id: location.sticker_id,
					created_at: location.created_at,
					updated_at: location.updated_at
				)
				delete_ss_sticker_location(location.id)
			end
			self.last_location = self.locations.last.address if self.locations.count > 0
		end
		self.last_location = 'Unknown' if self.last_location.nil?
	end

	private

		def after_create_callback
			self.histories.create!(subject: "sticker", operation: "created")
		end

		def after_update_callback
			self.histories.create!(subject: "sticker", operation: "updated")
		end

		def before_destroy_callback
			self.histories.create!(subject: "sticker", operation: "deleted")
		end

		def generate_code
			if self.code.nil? || self.code.empty?
				self.update_attributes(code: Digest::MD5::hexdigest(self.name + self.user_id.to_s + self.id.to_s))
			end
		end
end
