class ApplicationController < Sinatra::Base

  # set content-type for all responses
  set :default_content_type, 'application/json'

  # get '/' do
  #   { message: "Hello world" }.to_json
  # end

  get '/games' do
    # get all games from DB
    # games = Game.all
    # games = Game.all.sort_by(&:price).reverse
    # games = Game.all.order(:price).limit(10).reverse_order
    # games = Game.all.order(price: :desc).limit(10)

    games = Game.all.order(:title)

    # return a JSON response with an array of all game data
    games.to_json
  end

  #use :id syntax to create a dynamic route
  get '/games/:id' do
    # look up the game in the database using its ID
    game = Game.find(params[:id])

    # send a JSON-formatted response of the game data
    # game.to_json

    #include associated reviews in JSON response
    # game.to_json(include: :reviews)

    #include users associated with each review in JSON response
    game.to_json(only: [:id, :title, :genre, :price], include: { reviews: { include: :user} })

  end

end
