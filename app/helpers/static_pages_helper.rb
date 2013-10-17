module StaticPagesHelper

  # Web service

  def get_ws_stats
    web_service_url('stats.json')
    get_url
    return @parsed_json
  end
end
