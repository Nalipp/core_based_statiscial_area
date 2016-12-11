require "sinatra"
require "sinatra/content_for"
require "tilt/erubis"

require_relative "sequel_persistence"

configure do
  set :erb, escape_html: true
  set :port, 8080
end

configure(:development) do
  enable :sessions
  require "sinatra/reloader"
  also_reload "sequel_persistence.rb"
end

before do
  @storage = SequelPersistence.new(logger)
end

get "/" do
  redirect "/density"
end

get "/density" do
  @population_data = @storage.density
  erb :density, layout: :layout
end
