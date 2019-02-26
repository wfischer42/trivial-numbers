Rails.application.routes.draw do
  get '/', to: 'game#question'
  get '/game', to: 'game#question'
  post '/newgame', to: 'game#new'
end
