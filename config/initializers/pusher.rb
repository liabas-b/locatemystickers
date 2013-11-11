# config/initializers/pusher.rb
require 'pusher'

Pusher.app_id = '59098'
Pusher.key    = 'ba676f4f7e8139bcf138'
Pusher.secret = '1de4adeb808d4315eb92'
Pusher.url = "http://ba676f4f7e8139bcf138:1de4adeb808d4315eb92@api.pusherapp.com/apps/59098"
Pusher.logger = Rails.logger
