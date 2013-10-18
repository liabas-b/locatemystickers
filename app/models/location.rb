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
  attr_accessible :latitude, :longitude, :created_at, :gmaps, :id, :sticker_id, :updated_at, :version

  belongs_to :sticker
  has_many :histories

  validates :version, presence: true
  validates :sticker_id, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  after_validation :fetch_address
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode  # auto-fetch address

	default_scope order: 'locations.created_at DESC'

	acts_as_gmappable :process_geocoding => false


  # NOTIFICATION TRIGGERS
  after_create do |location|
    location.sticker.last_location = "Test"
    location.histories.create!(subject: "location", operation: "created", sticker_id: location.sticker.id)
  end
  after_update do |location|
    location.histories.create!(subject: "location", operation: "updated", sticker_id: location.sticker.id)
  end
  before_destroy do |location|
    location.histories.create!(subject: "location", operation: "deleted", sticker_id: location.sticker.id)
  end

  # No need? (depends on maps jquery)
  def gmaps4rails_marker_picture
    {
      "picture" => "/assets/marker.png",
      "width" => 16,
      "height" => 32
    }
  end

  def gmaps4rails_marker_infowindow
    render_to_string(:partial => "/locations/maps_info_window",
                    :locals => { :location => location })
  end

  def gmaps4rails_marker_title
    self.created_at.to_datetime
  end

  def gmaps4rails_marker_json
    render :json => { :id => self.id }
  end

  def self.search(search, column = 'name')
    if search
      where("#{column} LIKE ?", "%#{search}%")
    else
      scoped
    end
  end

end
