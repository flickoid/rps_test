require 'sinatra/base'
require './lib/player'
require './lib/game'


class RockPaperScissors < Sinatra::Base

configure :production do
  require 'newrelic_rpm'
end

  enable :sessions

  set :session_secret, 'super secret encryption key'

  use Rack::MethodOverride

  get '/' do
    erb :index
  end

  get '/new-game' do
  	erb :new_player
  end

  post '/register' do 
    session[:name] = params[:name] if params[:name]
    redirect '/rps'
  end

  get '/rps' do
    images_rock = ["/images/rock/rock1.jpg", "/images/rock/rock2.jpg", "/images/rock/rock3.jpg", "/images/rock/rock4.jpg", "/images/rock/rock5.jpg", "/images/rock/rock6.jpg"]
    @image_rock = images_rock.sample.to_s
    images_paper = ["/images/paper/paper1.jpg", "/images/paper/paper2.jpg", "/images/paper/paper3.jpg", "/images/paper/paper4.jpg", "/images/paper/paper5.jpg", "/images/paper/paper6.jpg"]
    @image_paper = images_paper.sample.to_s
    images_scissors = ["/images/scissors/scissors1.jpg", "/images/scissors/scissors2.jpg", "/images/scissors/scissors3.jpg", "/images/scissors/scissors4.jpg", "/images/scissors/scissors5.jpg", "/images/scissors/scissors6.jpg"]
    @image_scissors = images_scissors.sample.to_s
  	erb :play	
  end

  post "/play" do
  	player = Player.new(params[:name])
    session[:name] = params[:name]
  	player.picks = params[:pick]
  	computer = generate_computer
  	@game = Game.new(player, computer)
  	erb :outcome
  end

  # get '/next' do
  #   redirect to '/register'
  # end

  def generate_computer
  	choice = ["Rock","Paper","Scissors"].sample

  	comp = Player.new("computer")
  	comp.picks = choice
  	comp
  end



  # start the server if ruby file executed directly
  run! if app_file == $0
end
