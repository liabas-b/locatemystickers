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
          :sticker_configuration, :last_longitude, :last_latitude, :tags, :tags_attributes, :tags_as_string

  belongs_to :user

  has_many :locations, dependent: :destroy
  has_many :zones, dependent: :destroy
  has_many :histories
  has_many :tags, as: :taggable
  has_one :sticker_configuration

  accepts_nested_attributes_for :tags

  validates :name, presence: true, length: { maximum: 140 }
  validates :text, length: { maximum: 1024 }
  validates :user_id, presence: true

  default_scope order: 'stickers.updated_at DESC'

  # Callbacks
  before_save :generate_code
  after_create :after_create_callback
  after_update :after_update_callback
  before_destroy :before_destroy_callback
    
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

  def share_with (user)
    user.follow!(self.user.id, self.id)
  end

  def pack
      zones = Hash.new
      self.zones.each do |z|
        zones[:zone] = z
        zones[:fence] = z.locations
      end
      {
        sticker: self,
        zones: zones,
        locations: self.locations,
        histories: self.histories,
        configuration: self.sticker_configuration
      }
  end

  private

    def after_create_callback
      self.histories.create!(subject: "sticker", operation: "created", user_id: self.user_id)
      self.tags_as_string.split(";").each do |t|
        self.tags.create!(key: t.humanize) if Tag.find_by_key(t.humanize).nil?
      end
    end

    def after_update_callback
      self.histories.create!(subject: "sticker", operation: "updated", user_id: self.user_id)
      self.tags_as_string.split(";").each do |t|
        self.tags.create!(key: t.humanize) if Tag.find_by_key(t.humanize).nil?
      end
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
