# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  sticker_id :integer
#  latitude   :float
#  longitude  :float
#  gmaps      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  version    :integer          default(0)
#  address    :string(255)
#

class Location < ActiveRecord::Base
	attr_accessible :latitude, :longitude, :created_at, :id, :sticker_id, :updated_at, :sticker_code, :is_new, :date
	default_scope order: 'locations.id desc'

	# Relations #
	########
	belongs_to :sticker
	has_many :histories

	# Validations #
	#########
	validates :sticker_id, presence: true
	validates :latitude, presence: true
	validates :longitude, presence: true

	# Geocoding #
	#########
	reverse_geocoded_by :latitude, :longitude

	# Callbacks #
	########
	after_validation :fetch_address
	#, :reverse_geocoder
	# after_save :after_save_callback
	before_create :before_create_callback
	after_create :after_create_callback
	after_update :after_update_callback
	# before_destroy :before_destroy_callback

	# Methods #
	########

	def self.search(search, column = 'name')
		if search
			where("#{column} LIKE ?", "%#{search}%")
		else
			scoped
		end
	end

	def self.between_two_dates date_one, date_two
		where "created_at >= '#{date_one}' AND created_at <= '#{date_two}'"
	end

	def self.for_stickers stickers
		sticker_ids = ""
		i = 1
		stickers.map(&:id).each do |id|
			sticker_ids << id.to_s
			sticker_ids << ", " if i < stickers.count
			i += 1
		end
		where("sticker_id IN (#{sticker_ids})")
	end

	def self.get_max max
		limit(max.to_i)
	end

	private
		
		def before_create_callback
			self.date = Time.now
		 	self.is_new = true
		 	if self.sticker_id.nil? && self.sticker_code
		 		self.sticker = Sticker.find(self.sticker_code).id
		 	end
		 	if self.sticker_code.nil? && self.sticker_id
		 		self.sticker_code = self.sticker.code
		 	end
			self.sticker.touch
			self.sticker.last_longitude = self.longitude
			self.sticker.last_latitude = self.latitude
		end

		def after_create_callback
			self.histories.create!(subject: "location", operation: "created", sticker_id: self.sticker, user_id: self.sticker.user)

		      Pusher['locations_channel'].trigger('new_location', {
		      	location: self
		    	})
		end

		def after_update_callback
			self.histories.create!(subject: "location", operation: "updated", sticker_id: self.sticker, user_id: self.sticker.user)
		end

		def before_destroy_callback
			self.histories.create!(subject: "location", operation: "deleted", sticker_id: self.sticker, user_id: self.sticker.user)
		end

end
