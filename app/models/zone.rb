# == Schema Information
#
# Table name: zones
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  description     :string(255)
#  alert_level     :integer
#  alerts_on_enter :integer
#  alerts_on_exit  :integer
#  sticker_id      :integer
#  colour          :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Zone < ActiveRecord::Base
  attr_accessible :alert_level, :alerts_on_enter, :alerts_on_exit, :colour, :description, :name, :sticker_id, :locations

  belongs_to :sticker
  has_many :locations, class_name: 'ZoneLocations', :dependent => :destroy

  after_save {
  	generate_locations
  }

  def register_location(latitude, longitude)
		self.locations.create!(longitude: longitude, latitude: latitude)
  end

  def generate_locations
    i = 0
    4.times do
      self.locations.create!(zone_id: self.id,latitude: rand(50 - self.id) + Math.sin(i * 20) * 2, longitude: rand(50 - self.id) * Math.cos(i *20) * -1)
      i = i + 1
    end
  end
end
