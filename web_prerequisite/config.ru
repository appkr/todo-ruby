require 'pp'
require 'rack'

# class RackApplication
#   def call(env)
#     pp env
#     [200, {'Content-type' => 'text/plain'}, ['Hello']]
#   end
# end

# class RackApplication
#   def call(env)
#     # pp env
#     # [200, {'Content-type' => 'text/plain'}, ['Hello']]
#
#     request = Rack::Request.new(env)
#
#     response =
#       if request.path_info == '/'
#         body = "#{request.request_method}: Hello ! #{request.params['name']}!"
#         Rack::Response.new(body, 200, {'Content-type' => 'text/plain'})
#       else
#         Rack::Response.new('Not Found', 404, {'Content-type' => 'text/plain'})
#       end
#
#     response.finish
#   end
# end

# class RackApplication
#   def call(env)
#     [200, {'Content-type' => 'text/plain'}, ['Hello']]
#   end
# end
#
# use Rack::ShowStatus
# use Rack::Auth::Basic do |username, password|
#   username == password
# end

# class URLFilter
#   def initialize(app)
#     @app = app
#   end
#
#   def call(env)
#     if env['PATH_INFO'] == '/admin'
#       [404, {'Content-type' => 'text/plain'}, ["Not Found. (PATH=#{env['PATH_INFO']})"]]
#     else
#       @app.call(env)
#     end
#   end
# end
#
# class RackApplication
#   def call(env)
#     [200, {'Content-type' => 'text/plain'}, ["RackApplication(PATH=#{env['PATH_INFO']})"]]
#   end
# end
#
# use URLFilter
# use Rack::Auth::Basic do |username, password|
#   username == password
# end
#
# run RackApplication.new

# require './sinatra_classic'
# run Sinatra::Application

require './sinatra_modular'

run Application
