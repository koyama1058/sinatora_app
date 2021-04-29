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

get '/memos/new' do
  erb :new
end

post '/memos' do
  hash = { 'id' => SecureRandom.uuid, 'title' => params['title'], 'text' => params['text'] }
  File.open("memos/#{hash['id']}.json", 'w') { |f| f.puts JSON.generate(hash) }
  redirect '/memos'
end

get '/memos/:id/edit' do
  @memo = JSON.parse(File.read("memos/#{params[:id]}.json"))
  erb :edit
end

patch '/memos/:id' do
  hash = { 'id' => params[:id].to_s, 'title' => params['title'], 'text' => params['text'] }
  File.open("memos/#{hash['id']}.json", 'w') { |f| f.puts JSON.generate(hash) }
  redirect '/memos'
end

get '/memos/:id' do
  @memo = JSON.parse(File.read("memos/#{params[:id]}.json"))
  erb :show
end

delete '/memos/:id' do
  File.delete("memos/#{params[:id]}.json")
  redirect '/memos'
end
