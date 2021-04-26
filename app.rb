require 'sinatra'
require 'sinatra/reloader'
require 'pry'

get '/' do
  erb :index
end

get '/memo' do
  binding.pry
  erb :index
end

get '/memo/new' do
  erb :new
end

get '/memo/edit' do
  erb :edit
end

get '/memo/show' do
  erb :show
end