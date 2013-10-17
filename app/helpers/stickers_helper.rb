module StickersHelper
  include UsersHelper

  # Methods

	def count_active_stickers(stickers)
		count = 0
		stickers.each do |s|
			if s.is_active
				count = count + 1
			end
		end
		count
	end

  # Web Service

  def delete_ws_user_sticker(user_id, sticker_id)
    web_service_url('delete_sticker?user_id=' + user_id.to_s + '&id=' + sticker_id.to_s)
    get_url
    return @parsed_json
  end

  def update_ws_user_sticker(user_id, sticker)
    web_service_url('update_sticker?id=' + sticker['id'] + '&' + ({
      'sticker[sticker_type_id]' => sticker['sticker_type_id'],
      'sticker[text]' => sticker['text'],
      'sticker[code]' => sticker['code'],
      'sticker[version]' => sticker['version'],
      'sticker[is_active]' => sticker['is_active'],
      'sticker[user_id]' => sticker['user_id'],
      'sticker[name]' => sticker['name'] }).to_param.to_s)
    get_url
    updated_sticker = Sticker.new(@parsed_json)
    updated_sticker.id = @parsed_json['id']
    return updated_sticker
  end

  def search_ws_stickers(column = '', search = '', sort = '', direction = 'asc', paginate = false, per_page = 10, page = 1)
    column ||= 'name'
    search ||= ''
    sort ||= 'name'
    direction ||= 'asc'
    web_service_url('/stickers.json?column=' + column + '&search='+ search + '&sort=' + sort + '&direction=' + direction)
    get_url
    stickers = parse_stickers_from_parsed_json(paginate, per_page, page)
    return stickers
  end

  def search_ws_user_stickers(user_id, column = '', search = '', sort = '', direction = 'asc', paginate = false, per_page = 10, page = 1)
    column ||= 'name'
    search ||= ''
    sort ||= 'name'
    direction ||= 'asc'
    web_service_url('/users/' + user_id.to_s + '/stickers.json?column=' + column + '&search='+ search + '&sort=' + sort + '&direction=' + direction)
    get_url
    stickers = parse_stickers_from_parsed_json(paginate, per_page, page)
    return stickers
  end

  def search_ws_user_followed_stickers(user_id, column = '', search = '', sort = '', direction = 'asc', paginate = false, per_page = 10, page = 1)
    column ||= 'name'
    search ||= ''
    sort ||= 'name'
    direction ||= 'asc'
    web_service_url('/users/' + user_id.to_s + '/followed_stickers.json?column=' + column + '&search='+ search + '&sort=' + sort + '&direction=' + direction)
    get_url
    stickers = parse_stickers_from_parsed_json(paginate, per_page, page)
    return stickers
  end

  def get_ws_all_stickers(paginate = false, per_page = 10, page = 1)
    web_service_url('/stickers.json?search=' + params[:search] + '&column=' + params[:column] + '')
    get_url
    stickers = parse_stickers_from_parsed_json(paginate, per_page, page)
    return stickers
  end

  def get_ws_user_sticker(user_id, sticker_id)
    web_service_url('users/' + user_id.to_s + '/stickers/' + sticker_id.to_s + '.json')
    get_url
    sticker = parse_sticker_from_parsed_json
    return sticker
  end

  def get_ws_sticker_possessor(sticker_id)
    web_service_url('stickers/' + sticker_id.to_s + '/possessor.json')
    get_url
    sticker = parse_user_from_parsed_json
    return sticker
  end

  def get_ws_sticker(sticker_id)
    web_service_url('stickers.json?search=' + sticker_id.to_s + '&column=id')
    get_url
    sticker = parse_stickers_from_parsed_json.first
    return sticker
  end

  def get_ws_user_stickers(user_id, paginate = false, per_page = 10, page = 1)
    web_service_url('users/' + user_id.to_s + '/stickers.json')
    get_url
    stickers = parse_stickers_from_parsed_json(paginate, per_page, page)
    return stickers
  end

  def get_ws_user_followed_stickers(user_id, paginate = false, per_page = 10, page = 1)
    web_service_url('users/' + user_id.to_s + '/followed_stickers.json')
    get_url
    followed_stickers = parse_stickers_from_parsed_json(paginate, per_page, page)
    return followed_stickers
  end

  def parse_sticker_from_parsed_json
    sticker = Sticker.new(@parsed_json)
    sticker.id = @parsed_json['id']
    return sticker
  end

	def parse_stickers_from_parsed_json(paginate = false, per_page = 10, page = 1)
    stickers = Array.new
    @parsed_json.each do |sticker, r|
      s = Sticker.new(sticker)
      s.id = sticker['id']
      stickers.push(s)
    end
    if paginate == true
      stickers = stickers.paginate(:page => page, :per_page=> per_page)
    end
    return stickers
	end

end
