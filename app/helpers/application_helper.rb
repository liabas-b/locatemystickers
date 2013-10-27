module ApplicationHelper
  include UsersHelper
  include StickersHelper
  include MessagesHelper
  include LocationsHelper
  include ZonesHelper
  include HistoriesHelper
  include StaticPagesHelper
  include StickerConfigurationsHelper
  
  def total_locations_of_stickers(stickers)
    count = 0
    stickers.each do |s|
      count += s.locations.count
    end
    count
  end

  def link_to_submit(text)
    link_to_function text, "$(this).closest('form').submit()"
  end
  
  def fade_alert(type, value, emphase=nil)
    if emphase.nil?
      emphase = type.humanize.capitalize 
    end

    html = ""
    html << "<div class='alert alert-" + type + " fade in'>"
    html << "<button type='button' class='close' data-dismiss='alert'>&times;</button>"
    html << "<strong>" + emphase + "</strong>" + value + "</div>"
    html
  end

  def errors_for(object, message=nil)
    html = ""
    unless object.errors.blank?
      html << "<div class='formErrors #{object.class.name.humanize.downcase}Errors'>\n"
      if message.blank?
        if object.new_record?
          html << "\t\t<h5>There was a problem creating the #{object.class.name.humanize.downcase}</h5>\n"
        else
          html << "\t\t<h5>There was a problem updating the #{object.class.name.humanize.downcase}</h5>\n"
        end    
      else
        html << "<h5>#{message}</h5>"
      end  
      html << "\t\t<ul>\n"
      object.errors.full_messages.each do |error|
        html << "\t\t\t<li>#{error}</li>\n"
      end
      html << "\t\t</ul>\n"
      html << "\t</div>\n"
    end
    html
  end 

	def full_title(page_title)
    base_title = "LocateMyStickers"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
	end
	
  def encapsulate_data(data)
    json = data
    render :json => json
  end
  
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

  def sticker_type_name(sticker)
    @type = StickerType.find_by_id(sticker.sticker_type_id)
    @type.name
  end

  def sticker_type_icon(sticker)
    @type = StickerType.find_by_id(sticker.sticker_type_id)
    content_tag(:span, "", class: @type.icon)
  end

  # Web service
  
  def web_service_url(data = nil)
    @data_url = 'http://www.web-service.locatemystickers.com/' + data
    return @data_url
  end

  def get_url
    CLogger.info('Started GET ' + @data_url)
    url = URI.parse(@data_url)
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
    @parsed_json = ActiveSupport::JSON.decode(res.body)
    CLogger.info('Request returned ' + @parsed_json.to_s)
  end

  def post_url
    CLogger.info('Started POST ' + @data_url)
    url = URI.parse(@data_url)
    req = Net::HTTP::Post.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
    @parsed_json = ActiveSupport::JSON.decode(res.body)
    CLogger.info('Request returned ' + @parsed_json.to_s)
  end

  def put_url
    CLogger.info('Started PUT ' + @data_url)
    url = URI.parse(@data_url)
    req = Net::HTTP::Put.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
    @parsed_json = ActiveSupport::JSON.decode(res.body)
    CLogger.info('Request returned ' + @parsed_json.to_s)
  end

  def delete_url
    CLogger.info('Started DELETE ' + @data_url)
    url = URI.parse(@data_url)
    req = Net::HTTP::Delete.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
    @parsed_json = ActiveSupport::JSON.decode(res.body)
    CLogger.info('Request returned ' + @parsed_json.to_s)
  end

  # Stickers server

  def stickers_server_url(data = nil)
    # @data_url = 'http://127.0.0.1:3333/' + data
    @data_url = 'http://stickersserver.herokuapp.com/' + data
    return @data_url
  end

  def get_ss_sticker_last_location(sticker_code)
    stickers_server_url('locations.json?search=' + sticker_code + '&last=true')
    get_url
    return Location.new(@parsed_json)
  end
 
  def get_ss_sticker_locations(sticker_code, page = nil)
    if page.nil?
      stickers_server_url('locations.json?search=' + sticker_code + '&column=sticker_code&paginate=false')
    else
      stickers_server_url('locations.json?search=' + sticker_code + '&column=sticker_code&paginate=true&page=' + page.to_s)
    end
    get_url
    return parse_ss_locations_from_parsed_json
  end

  def get_ss_sticker_last_location(sticker_code, number_limit = nil, date_limit = nil)
    stickers_server_url('last_location?sticker_code=' + sticker_code)
    get_url
    return @parsed_json
  end

  def delete_ss_sticker_location(location_id, number_limit = nil, date_limit = nil)
    stickers_server_url('locations/' + location_id.to_s + '.json')
    delete_url
    return @parsed_json
  end

  def post_ss_sticker_configuration(configuration)
    stickers_server_url('sticker_configurations.json?sticker_configuration[activate]=' + configuration.activate.to_s + '&sticker_configuration[sticker_code]=' + configuration.sticker_code + '&sticker_configuration[frequency_update]=' + configuration.frequency_update.to_s)
    post_url
    return @parsed_json
  end

  def generate_documentation(params)
    Prawn::Document.new do
      params.each do |key, value|
        text key, align: :center
        value.each do |k, v|
          text "#{k}: #{v}"
        end
      end
    end.render
  end
end
