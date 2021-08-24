Rails.application.routes.draw do
  get '/expand_url', to: 'url#expand_url'
  get '/url_expander', to: 'url#url_expander'
end
