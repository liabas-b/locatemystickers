# == Schema Information
#
# Table name: zones
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  description     :string(255)
#  alert_level     :integer
#  alerts_on_enter :integer
#  alerts_on_exit  :integer
#  sticker_id      :integer
#  colour          :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe Zone do
  pending "add some examples to (or delete) #{__FILE__}"
end
