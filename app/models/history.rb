# == Schema Information
#
# Table name: histories
#
#  id                     :integer          not null, primary key
#  subject                :string(255)
#  operation              :string(255)
#  user_id                :integer          default(0)
#  sticker_id             :integer          default(0)
#  location_id            :integer          default(0)
#  message_id             :integer          default(0)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  notification_level     :integer          default(0)
#  notify                 :integer          default(0)
#  notification_confirmed :integer          default(0)
#

class History < ActiveRecord::Base
  attr_accessible :subject, :operation, :notification_confirmed, :created_at, :id, :location_id, :message_id, :notification_level, :notify, :sticker_id, :updated_at, :user_id

  belongs_to :user
  belongs_to :sticker
  belongs_to :location
  belongs_to :message

  after_create :broadcast
    
  def self.search(search, column = 'subject')
    if search
      where("#{column} LIKE ?", "%#{search}%")
    else
      scoped
    end
  end

  def broadcast
    # TODO
  end
end
