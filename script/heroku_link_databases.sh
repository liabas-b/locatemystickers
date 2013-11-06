source_app=$1
destination_app=$2
heroku config:set DATABASE_URL=`heroku config:get DATABASE_URL -a $source_app` -a $destination_app
