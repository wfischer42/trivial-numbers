Rails.application.routes.draw do
  get '/', to: 'game#question'
  put '/', to: 'game#answer'
  post '/', to: 'game#new'
end
