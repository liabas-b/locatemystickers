# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  from_user_id :integer
#  subject      :string(255)
#  content      :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Message < ActiveRecord::Base
  attr_accessible :content, :from_user_id, :subject, :user_id, :created_at, :id, :updated_at

  belongs_to :user
  belongs_to :from_user, class_name: 'User'

  validates :subject, :presence => true
  validates :content, :presence => true

  def self.count_sent_messages(user, messages)
  	messages.select{ |m| m.from_user_id == user.id }.count
  end

  def self.count_received_messages(user, messages)
  	messages.select{ |m| m.user_id == user.id }.count
  end
end
