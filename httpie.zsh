#!/bin/zsh

# https://httpie.io/docs/cli
# https://github.com/stedolan/jq

LOCALHOST_BEARER=$(http -f POST localhost:9292/api/v1/auth email=abc@test.test password=123 | jq -r .token)  
echo "Current token: $LOCALHOST_BEARER" 
sleep 1

http -A bearer -a $LOCALHOST_BEARER localhost:9292/api/v1/items 
sleep 2

http -A bearer -a $LOCALHOST_BEARER localhost:9292/api/v1/items/1
sleep 2

http -A bearer -a $LOCALHOST_BEARER localhost:9292/api/v1/items/0
sleep 2

# https://httpie.io/docs/cli/nested-json
http -A bearer -a $LOCALHOST_BEARER POST localhost:9292/api/v1/locations "locations[]:={\"latitude\": 55, \"longitude\": 10}"
sleep 2

http -A bearer -a $LOCALHOST_BEARER localhost:9292/api/v1/locations
sleep 2

http -A bearer -a "failing_token!$" POST localhost:9292/api/v1/locations "locations[]:={\"latitude\": 55, \"longitude\": 10}"
