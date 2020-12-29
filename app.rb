require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'

require_relative 'repo/cookbook'
require_relative 'model/recipe'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end

get '/' do
  @cookbook = Cookbook.new('recipes.csv')
  erb :index
end

get '/new' do
  erb :new
end

post '/new' do
  new_recipe = Recipe.new(params[:recipeName], params[:recipeDescription], params[:recipeRating], params[:recipePrepTime])
  @cookbook = Cookbook.new('recipes.csv')
  @cookbook.add_recipe(new_recipe)
  redirect to('/')
end

get '/about' do
  erb :about
end

get '/team/:username' do
  puts params[:username]
  "The username is #{params[:username]}"
end
