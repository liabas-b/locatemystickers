
class MapController < ApplicationController
  layout 'map.html.erb'

  def map_demo
    unless current_user.nil?
      Sticker.delay.broadcast_way_for_stickers(current_user.stickers)
    end
  end

  def map
  end
end
