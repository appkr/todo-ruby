require 'sinatra'

get '/' do
  puts "params                  => #{params}"
  puts "params.class            => #{params.class}"
  puts "request                 => #{request}"
  puts "request.class.ancestors => #{request.class.ancestors}"
end