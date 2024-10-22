# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#  compteur        :integer          default(0)
#  first_name      :string(255)
#  last_name       :string(255)
#  zip_code        :string(255)
#  city            :string(255)
#  country         :string(255)
#  adress          :string(255)
#  phone           :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :name, :first_name, :last_name, :adress, :zip_code, :country, :city, :phone,
          :email, :password, :password_confirmation, :email_confirmation,
          :remember_token, :relationships, :compteur, :stickers, :followed_id, :notifications,
          :admin, :created_at, :id, :password_digest, :updated_at
                  
  # Relations #
  ########

  has_secure_password

  has_many :histories
  has_many :notifications, class_name: "History", :conditions=>{:notify => 1}, limit: 15, dependent: :destroy, order: 'id desc'
  has_many :new_notifications, class_name: "History", :conditions=>{:notify => 1, :notification_confirmed => 0}, dependent: :destroy, order: 'id desc'
  has_many :messages, dependent: :destroy, foreign_key: "user_id"

  has_many :stickers, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_stickers, through: :relationships, source: :sticker
  has_many :reverse_relationships, foreign_key: "owner_id", class_name: "Relationship", dependent: :destroy
  has_many :shared_stickers, through: :reverse_relationships, source: :sticker

  has_many :friendships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :friendships, source: :followed
  has_many :reverse_friendships, foreign_key: "followed_id", class_name: "Friendship", dependent: :destroy
  has_many :followers, through: :reverse_friendships, source: :follower

  # Validation #
  ########

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  # Filters #
  ######
  after_create :after_create_callback
  after_update :after_update_callback
  before_destroy :before_destroy_callback
  before_save do |user|
    user.email = email.downcase
    user.name = user.first_name + " " + user.last_name
    create_remember_token
  end

  # Methods #
  ########

  
  def self.search(search, column = 'name')
    if search
      where("#{column} LIKE ?", "%#{search}%")
    else
      scoped
    end
  end

  def self.sent_messages(user)
    Message.where('messages.from_user_id=' + user.id.to_s)
  end

  
  # Sticker sharing

  def following?(sticker)
    relationships.find_by_sticker_id(sticker.id)
  end

  def follow!(owner_id, sticker_id)
    relationships.create!(  owner_id: owner_id,
                sticker_id: sticker_id,
                follower_id: self.id)
  end

  def unfollow!(sticker)
    relationships.find_by_sticker_id(sticker.id).destroy
  end
  

  # Friendships
  
  def is_friend?(other_user)
    friendships.find_by_followed_id(other_user.id)
  end

  def add_friend!(other_user)
    friendships.create!(followed_id: other_user.id)
    other_user.add_friend!(self) unless other_user.is_friend?(self)
  end

  def remove_friend!(other_user)
    friendships.find_by_followed_id(other_user.id).destroy
  end

  def send_message!(other_user, content)
    message = Message.create!(from_user_id: self.id, user_id: other_user.id, content: content)
    message.save
  end

  def pack_default_data
      data = Hash.new
      data[:stickers] = self.pack_stickers
      data[:user] = self.pack
      data
  end

  def pack
    {
          user: self,
          messages: self.messages,
          friends: self.followed_users,
          histories: self.histories
    }
  end

  def pack_stickers
      stickers = Array.new
      self.stickers.each do |s|
        stickers << s.pack
      end
      stickers
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def after_create_callback
      self.histories.create!(subject: "user", operation: "created")
      UserMailer.welcome_email(self).deliver
    end

    def after_update_callback
      self.histories.create!(subject: "user", operation: "updated")
    end

    def before_destroy_callback
      self.histories.create!(subject: "user", operation: "deleted")
    end
end
