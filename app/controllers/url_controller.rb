class UrlController < ApplicationController
  def expand_url
    url = params[:url]
    # pulls apart url and places them in objects which you can access 
    uri = URI(url)
    #executes and gets response and saves into response
    response = Net::HTTP.get_response(uri)
    #checks if a location exists (a redirect)
    redirect_location = response.header["location"] 
    content_type = response.header["content-type"] 

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
      content_type = response.header["content-type"] 

    end
    #returns original url(user inputted), number of redirects, and final url destination
    display_response = {original_url: params[:url], num_redirects: count, final_url: url, response_format: content_type} 
    render json: display_response.to_json
  end

  def url_expander
    render "url_expander"
  end
end
