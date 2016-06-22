require 'sinatra'

# 위에 부터 먼저 매칭한다.

get '/profile' do
  'profile'
end

get '/:name' do
  "Hi #{params[:name]}"
end

