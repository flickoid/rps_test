require 'rubygems'
require File.join(File.dirname(__FILE__), 'server.rb')
use Rack::Static, :urls => ["/css", "/images"], :root => "public"

run RockPaperScissors