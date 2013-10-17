module LocationsHelper

	# Web service

	def get_ws_stickers_total_locations_count(stickers)
		count = 0
		stickers.each do |s|
		    web_service_url('users/' + s.user_id.to_s + '/stickers/' + s.id.to_s + '/locations/count.json')
		    get_url
	    	count += @parsed_json
		end
	    return count
	end

	def get_ws_user_sticker_location(user_id, sticker_id, location_id, paginate = false, per_page = 10, page = 1)
	    web_service_url('users/' + user_id.to_s + '/stickers/' + sticker_id.to_s + '/locations/' + location_id.to_s + '.json')
	    get_url
	    location = parse_location_from_parsed_json(paginate, per_page, page)
	    return location
	end

	def get_ws_user_sticker_locations(user_id, sticker_id, paginate = false, per_page = 10, page = 1)
	    web_service_url('users/' + user_id.to_s + '/stickers/' + sticker_id.to_s + '/locations.json')
	    get_url
	    locations = parse_locations_from_parsed_json(paginate, per_page, page)
	    return locations
	end

	def get_ws_all_locations(paginate = false, per_page = 10, page = 1)
	    web_service_url('locations.json')
	    get_url
	    locations = parse_locations_from_parsed_json(paginate, per_page, page)
	    return locations
	end

	def parse_location_from_parsed_json(paginate = false, per_page = 10, page = 1)
	    location = Location.new(@parsed_json)
	    location.id = @parsed_json['id']
	    return location
	end

	def parse_locations_from_parsed_json(paginate = false, per_page = 10, page = 1)
	    locations = Array.new
	    @parsed_json.each do |location, r|
	      l = Location.new(location)
	      l.id = location['id']
	      locations.push(l)
	    end
	    locations = locations.paginate(:page => page, :per_page=> per_page) if paginate
	    return locations
	end

	def parse_ss_locations_from_parsed_json(paginate = false, per_page = 10, page = 1)
	    locations = Array.new
	    @parsed_json.each do |location, r|
            sticker = Sticker.find_by_code(location['sticker_code'])
            CLogger.debug "parse_ss_locations_from_parsed_json: sticker: " + sticker.inspect.to_s + " location[:sticker_code]: " + location['sticker_code']
	      l = Location.new(:latitude => location['latitude'],
                        :longitude => location['longitude'],
                        :sticker_id => sticker.id,
                        :created_at => location['created_at'],
                        :updated_at => location['updated_at'])
	      l.id = location['id']
	      locations.push(l)
	    end
	    locations = locations.paginate(:page => page, :per_page=> per_page) if paginate
	    return locations
	end

end
