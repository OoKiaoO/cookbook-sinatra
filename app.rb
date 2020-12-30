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

cookbook = Cookbook.new('recipes.csv')

get '/' do
  @cookbook = Cookbook.new('recipes.csv')
  erb :index
end

get '/new' do
  erb :new
end

post '/new' do
  new_recipe = Recipe.new(params[:recipeName], params[:recipeDescription], params[:recipeRating], params[:recipePrepTime])
  cookbook.add_recipe(new_recipe)
  redirect to('/')
end

get '/delete/:index' do
  params[:index]
  # @cookbook = Cookbook.new('recipes.csv')
  cookbook.remove_recipe(params[:index].to_i)
  redirect to('/')
end

get '/done/:index' do
  params[:index]
  # @cookbook = Cookbook.new('recipes.csv')
  cookbook.mark_recipe_done(params[:index].to_i)
  redirect to('/')
end
