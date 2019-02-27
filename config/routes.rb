Rails.application.routes.draw do
  get '/', to: 'game#question'
  post '/', to: 'game#answer'
  post '/newgame', to: 'game#new'
end
