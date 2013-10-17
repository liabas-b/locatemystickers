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

require 'spec_helper'

describe Simulation do
  pending "add some examples to (or delete) #{__FILE__}"
end
