# == Schema Information
#
# Table name: zone_locations
#
#  id         :integer          not null, primary key
#  zone_id    :integer
#  latitude   :float
#  longitude  :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ZoneLocations < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :zone_id

  belongs_to :zone

  acts_as_gmappable :process_geocoding => false

  def sticker
  	Sticker.find(Zone.find(self.zone_id).sticker.id)
  end
end
