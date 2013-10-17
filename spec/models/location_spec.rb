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

require 'spec_helper'

describe Location do
  pending "add some examples to (or delete) #{__FILE__}"
end
