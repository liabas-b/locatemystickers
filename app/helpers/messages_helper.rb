module MessagesHelper
	def get_message_subject(sender, receiver)
    other_message = Message.find_by_subject(sender.name + " " + receiver.name)
    if (other_message.nil?)
      other_message = Message.find_by_subject(receiver.name + " " + sender.name)
    end
    if (other_message.nil?)
      subject = sender.name + " " + receiver.name
    else
      subject = other_message.subject
    end
    subject
	end

  # Web service

  def create_ws_message(message)
    CLogger.debug 'create_ws_message: message:' + message.inspect.to_s
    web_service_url('create_message?' + ({
      'message[content]' => message['content'],
      'message[from_user_id]' => message['from_user_id'],
      'message[user_id]' => message['user_id'],
      'message[subject]' => message['subject'] }).to_param.to_s)
    update_or_create_message(message)
    CLogger.debug 'create_ws_message: @parsed_json:' + @parsed_json.to_s
    return Message.new(@parsed_json)
  end

  def get_ws_user_message(user_id, message_id)
    web_service_url('users/' + user_id.to_s + '/messages/' + message_id.to_s + '.json')
    get_url
    message = parse_message_from_parsed_json
    CLogger.info 'get_ws_user_message: got message: ' + message.inspect.to_s
    return message
  end

  def get_ws_user_messages(user_id)
    web_service_url('users/' + user_id.to_s + '/messages.json')
    get_url
    messages = parse_messages_from_parsed_json
    CLogger.info 'get_ws_user_messages: got messages: ' + messages.count.to_s
    return messages
  end

  def get_ws_all_messages(paginate = false, per_page = 10, page = 1)
    web_service_url('/messages.json')
    get_url
    messages = parse_messages_from_parsed_json(paginate, per_page, page)
    return messages
  end

  def update_or_create_message(message)
    CLogger.info('Started GET update_or_create_message ' + @data_url)
    url = URI.parse(@data_url)
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
    @parsed_json = ActiveSupport::JSON.decode(res.body)
    CLogger.info('Request returned ' + @parsed_json.to_s)
  end

  def parse_message_from_parsed_json
      message = Message.new(@parsed_json)
      message.id = @parsed_json['id']
      return message
  end

  def parse_messages_from_parsed_json(paginate = false, per_page = 10, page = 1)
    CLogger.info 'parse_messages_from_parsed_json: @parsed_json: ' + @parsed_json.to_s
    messages = Array.new
    @parsed_json.each do |message, r|
      m = Message.new(message)
      m.id = message['id']
      messages.push(m)
    end
    return messages
  end
end
