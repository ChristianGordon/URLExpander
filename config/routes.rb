Rails.application.routes.draw do
  get '/url_expander', to: 'url#expand_url'

end
