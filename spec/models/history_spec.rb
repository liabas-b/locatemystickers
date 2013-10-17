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

require 'spec_helper'

describe History do
  pending "add some examples to (or delete) #{__FILE__}"
end
