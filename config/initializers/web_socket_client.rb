# require 'faye/websocket'
# require 'eventmachine'
# require 'singleton'

# $websocket_clients = []


#   EM.run {
#     ws = Faye::WebSocket::Client.new('ws://12.12.12.7:4242/')

#     ws.on :open do |event|
#       p [:open]
#       $websocket_clients << ws
#       ws.send('Hello, web app client connected !')
#       CLogger.debug "Websocket opened"
#     end

#     ws.on :message do |event|
#       p [:message, event.data]
#       CLogger.debug "Websocket received " + event.data.to_s
#     end

#     ws.on :close do |event|
#       CLogger.debug "Websocket close"
#       $websocket_clients.delete(ws)
#       p [:close, event.code, event.reason]
#       ws = nil
#     end
#   }
