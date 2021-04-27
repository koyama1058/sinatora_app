require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'json'
require 'securerandom'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

get '/memos' do
  files = Dir.glob('memos/*').sort_by { |file| File.mtime(file) }
  @memos = files.map { |file| JSON.parse(File.read(file)) }
  erb :index
end

get '/memo/new' do
  erb :new
end

post '/memo/new' do
  hash = { 'id' => SecureRandom.uuid, 'title' => params['title'], 'text' => params['text'] }
  File.open("memos/#{hash['id']}.json", 'w') { |f| f.puts JSON.generate(hash) }
  redirect '/memos'
end

get '/memo/edit/:id' do
  file = Dir.glob("memos/#{params[:id]}.json")
  @memo = JSON.parse(File.read(file[0]))
  erb :edit
end

patch '/memo/edit/:id' do
  hash = { 'id' => params[:id].to_s, 'title' => params['title'], 'text' => params['text'] }
  File.open("memos/#{hash['id']}.json", 'w') { |f| f.puts JSON.generate(hash) }
  redirect '/memos'
end

get '/memo/show/:id' do
  file = Dir.glob("memos/#{params[:id]}.json")
  @memo = JSON.parse(File.read(file[0]))
  erb :show
end

delete '/memo/:id' do
  file = Dir.glob("memos/#{params[:id]}.json")
  File.delete(file[0])
  redirect '/memos'
end
