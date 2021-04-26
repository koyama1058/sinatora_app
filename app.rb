require 'sinatra'
require 'sinatra/reloader'

get '/' do
  'メモ一覧表示'
end

get '/memo' do
  'メモの投稿画面'
end

