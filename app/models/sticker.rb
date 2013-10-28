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
          :sticker_configuration, :last_longitude, :last_latitude

  belongs_to :user
  has_many :locations, dependent: :destroy
  has_many :zones, dependent: :destroy
  has_many :histories
  has_one :sticker_configuration

  validates :name, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  default_scope order: 'stickers.updated_at DESC'

  # Callbacks
  # before_save :generate_code
  # after_create :after_create_callback
  after_initialize :after_initialize_callback
  # after_update :after_update_callback
  # before_destroy :before_destroy_callback
    
    def self.find(input)
      if input.is_a?(Integer) || input.to_i != 0
          super
        else
          find_by_code(input)
        end
  end

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
      # delay(run_at: 1.minute.from_now, queue: 'default').do_update_locations
    else
      self.last_location = 'Unknown' if self.last_location.nil?
    end
  end

  def do_update_locations
      new_locations = get_ss_sticker_locations(self.code)
      puts "[Sticker #{self.code} do_update_locations] got: " + new_locations.inspect
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
      # PousseMailer.send_alert.deliver
  end

  def update_last_location
    # if self.code and not self.code.empty?
    #   new_location = get_ss_sticker_last_location(self.code)
    #   if new_location
    #     self.locations.create!( 
    #       latitude: new_location['latitude'],
    #       longitude: new_location['longitude'],
    #       created_at: new_location['created_at'],
    #       updated_at: new_location['updated_at']
    #     )
    #     self.last_location = self.locations.last.address if self.locations.count > 0
    #   end
    # end
    if self.locations && self.locations.count > 0
      self.last_location = 'Unknown' if self.last_location.nil?
      self.last_longitude = self.locations.last.longitude
      self.last_latitude = self.locations.last.latitude
      self.save!
    end
  end

  def share_with (user)
    user.follow!(self.user.id, self.id)
  end

  private

    def after_initialize_callback
      self.update_last_location
    end

    def after_create_callback
      self.histories.create!(subject: "sticker", operation: "created", user_id: self.user_id)
    end

    def after_update_callback
      self.histories.create!(subject: "sticker", operation: "updated", user_id: self.user_id)
    end

    def before_destroy_callback
      self.histories.create!(subject: "sticker", operation: "deleted", user_id: self.user_id)
    end

    def generate_code
      if self.code.nil? || self.code.empty?
        self.update_attributes(code: Digest::MD5::hexdigest(self.name + self.user_id.to_s + self.id.to_s))
      end
    end
end
