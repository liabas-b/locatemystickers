# == Schema Information
#
# Table name: simulations
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  sticker_id     :integer
#  locations_sent :integer
#  description    :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Simulation < ActiveRecord::Base
  attr_accessible :description, :locations_sent, :sticker_id, :user_id
end
