rails_env = 'production'

threads 4,4

bind  "unix:///home/webservice/web-service/tmp/sockets/webapp.sock"
pidfile "/home/webservice/web-service/tmp/puma/pid"
state_path "/home/webservice/web-service/tmp/puma/state"

activate_control_app
