class UrlController < ApplicationController
  def expand_url
    url = params[:url]
    # pulls apart url and places them in objects which you can access 
    uri = URI(url)
    #executes and gets response and saves into response
    response = Net::HTTP.get_response(uri)
    #checks if a location exists (a redirect)
    redirect_location = response.header["location"] 

    count = 0

    while(redirect_location != nil)
      count += 1
      url = redirect_location
      # pulls apart url and places them in objects which you can access 
      uri = URI(url)
      #executes and gets response and saves into response
      response = Net::HTTP.get_response(uri)
      #checks if a location exists (a redirect)
      redirect_location = response.header["location"]
    end
    #returns original url(user inputted), number of redirects, and final url destination
    response = {original_url: params[:url], num_redirects: count, final_url: url} 
    render json: response.to_json
  end

  def url_expander
    
  end
end
