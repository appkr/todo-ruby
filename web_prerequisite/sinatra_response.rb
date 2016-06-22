require 'sinatra'

get '/' do
  'response sample'
end

get '/response' do
  status 404
  headers 'Content-type' => 'text/plain'
  body 'response sample'
end