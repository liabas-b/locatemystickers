class WebSocketMessage < ActiveRecord::Base
  attr_accessible :channel, :content, :is_pending
end
