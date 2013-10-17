module HistoriesHelper

	def get_user_notifications
		unless current_user.nil?
			@new_notifications = History.where("user_id=" + current_user.id.to_s + " AND notify=1 AND notification_confirmed=0")
			@old_notifications = History.where("user_id=" + current_user.id.to_s + " AND notify=1 AND notification_confirmed=1").limit(10)
		end
	end

	def dropdown_notifications
		@notifications = History.where("user_id=" + current_user.id.to_s + " AND notify=1 AND notification_confirmed=0")
	end

	# Web service

	def get_ws_user_new_notifications(user_id)
		web_service_url('users/' + user_id.to_s + '/new_notifications.json')
   		get_url
	    return parse_histories_from_parsed_json
	end

	def get_ws_user_old_notifications(user_id)
		web_service_url('users/' + user_id.to_s + '/old_notifications.json')
   		get_url
	    return parse_histories_from_parsed_json
	end

	def ws_confirm_notificaton(history_id)
		web_service_url('/histories/' + history_id.to_s + '/confirm.json')
		get_url
		return @parsed_json
	end

	def get_ws_stickers_total_histories_count(stickers)
		count = 0
		stickers.each do |s|
		    web_service_url('users/' + s.user_id.to_s + '/stickers/' + s.id.to_s + '/histories/count.json')
		    get_url
	    	count += @parsed_json
		end
	    return count
	end

	def get_ws_user_history(user_id, history_id, paginate = false, per_page = 10, page = 1)
	    web_service_url('users/' + user_id.to_s + '/histories/' + history_id.to_s + '.json')
	    get_url
	    history = parse_history_from_parsed_json(paginate, per_page, page)
	    return history
	end

	def get_ws_user_histories(user_id, paginate = false, per_page = 10, page = 1)
	    web_service_url('users/' + user_id.to_s + '/histories.json')
	    get_url
	    histories = parse_histories_from_parsed_json(paginate, per_page, page)
	    return histories
	end

	def get_ws_all_histories(paginate = false, per_page = 10, page = 1)
	    web_service_url('histories.json')
	    get_url
	    histories = parse_histories_from_parsed_json(paginate, per_page, page)
	    return histories
	end

	def parse_history_from_parsed_json(paginate = false, per_page = 10, page = 1)
	    history = History.new(@parsed_json)
	    history.id = @parsed_json['id']
	    return history
	end

	def parse_histories_from_parsed_json(paginate = false, per_page = 10, page = 1)
	    histories = Array.new
	    @parsed_json.each do |history, r|
	      h = History.new(history)
	      h.id = history['id']
	      histories.push(h)
	    end
	    histories = histories.paginate(:page => page, :per_page=> per_page) if paginate
	    return histories
	end

end
