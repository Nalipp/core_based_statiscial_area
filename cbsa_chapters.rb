require "pry"

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
  session[:pop_range] ||= "all"
  session[:data_type] ||= "density"
end

get "/" do
  redirect "/density"
end

get "/density" do
  @population_data = @storage.density_all
  erb :density, layout: :layout
end

def get_page(pop_data, data_type)
  @population_data = pop_data
  case data_type
  when "age"
    erb :age, layout: :layout
  when "pop_change"
    erb :pop_change, layout: :layout
  when "race"
    erb :race, layout: :layout
  else "density"
    erb :density, layout: :layout
  end
end

post "/pop_range" do
  new_pop_range = params[:pop_range]
  data_type = session[:data_type]
  session[:pop_range] = new_pop_range
  pop_data = @storage.get_population_data([new_pop_range, data_type])
  get_page(pop_data, data_type)
end

post "/data_type" do
  new_data_type = params[:data_type]
  pop_range = session[:pop_range]
  session[:data_type] = new_data_type
  pop_data = @storage.get_population_data([pop_range, new_data_type])
  get_page(pop_data, new_data_type)
end

get "/current_query" do
  pop_range = session[:pop_range] || 'all'
  data_type = session[:data_type] || 'density'
  pop_data = @storage.get_population_data([pop_range, data_type])
  get_page(pop_data, data_type)
end

get "/city_data/:city_name" do
  @city_data = @storage.city_data(params[:city_name])

  erb :city_data, layout: :layout
end
