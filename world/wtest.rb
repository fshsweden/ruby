require_relative "world"
require "json"

w = World.new

w.init
puts w.get_users

up = w.get_users_pos   # to json
hsh = JSON.parse up    # from json
puts hsh

