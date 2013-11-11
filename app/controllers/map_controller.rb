
class MapController < ApplicationController

  def map_demo
    unless current_user.nil?
      Sticker.delay.broadcast_way_for_stickers(current_user.stickers)
    end
  end

  def initialize_user_data
    data = Hash.new
    data[:stickers] = Array.new
    current_user.stickers.each do |s|
      sticker = Hash.new(s.to_json)
      sticker[:locations] = s.locations
      data[:stickers] << sticker
    end
    render :json => data
  end

  def map
    map_demo
    render layout: 'map.html.erb'
  end
end
