
class MapController < ApplicationController
  layout 'map.html.erb'

  def map_demo
    unless current_user.nil?
      Sticker.delay.broadcast_way_for_stickers(current_user.stickers)
    end
  end

  def initialize_user_data
    unless current_user.nil?
      render :json => current_user.pack_default_data
    else
      render :json => false, status: :not_found
    end
  end


  def map
    Pusher['test_channel'].trigger('my_event', {
      message: 'hello world'
    })
  end
end
