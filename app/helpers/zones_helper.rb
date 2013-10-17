module ZonesHelper

	# Web service

	def get_ws_user_sticker_zones(user_id, sticker_id)
	    web_service_url('users/' + user_id.to_s + '/stickers/' + sticker_id.to_s + '/zones.json')
	    get_url
	    zones = parse_zones_from_parsed_json
	    return zones
	end

	def parse_zones_from_parsed_json
	    zones = Array.new
	    @parsed_json.each do |zone, r|
	      z = zone.new(zone)
	      z.id = zone['id']
	      zones.push(z)
	    end
	    zones = zones.paginate(:page =>   params[:page], :per_page=> 10)
	    return zones
	end
end
