#
#
#
#
#
#
#
require 'sinatra' 
require 'json' 
require_relative 'world'

world = World.new
world.init
world.test

###### Sinatra Part ###### 

set :port, 8080 
set :environment, :production 

get '/getpos' do 
  return_message = {} 
  if params.has_key?('name')
    name = params['name'] 
    return_message = world.get_position name
  end 
  return_message.to_json 
end 

post "/updpos" do
  request.body.rewind  # in case someone already read it
  data = JSON.parse request.body.read
  puts data.inspect
  world.update_position data["name"], data["lat"], data["lng"]

  return "success".to_json
end

post "/hej" do
  return_message = {} 
  jdata = JSON.parse(params[:data],:symbolize_names => true) 
  if jdata.has_key?(:name) && jdata.has_key?(:lat) && jdata.has_key?(:lng) 
    world.update_pos jdata[:name], jdata[:lat], jdat[:lng]
    return_message[:status] = 'done' 
  else 
    return_message[:status] = 'missing argument name, lat or lng' 
  end 
  return_message.to_json 
end 
