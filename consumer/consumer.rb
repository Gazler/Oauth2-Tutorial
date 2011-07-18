require 'sinatra'  
require 'oauth2'  
  
def client  
  OAuth2::Client.new('6IFWs6UowWqbDa4u1LCbZBpXWs2c8WbnkloWd90u', 'CosAmQVJcXPCFX4nqynCH6p67Yv2znLkOT3KpsiO', :site => 'http://localhost:3000')  
end  
  
get '/auth/test' do  
  redirect client.web_server.authorize_url(  
    :redirect_uri => redirect_uri
  )  
end  
  
get '/auth/test/callback' do  
  access_token = client.web_server.get_access_token(params[:code], :redirect_uri => redirect_uri)  
  p access_token
  response = access_token.get('/api/v1/data.json')
  response.inspect
end  
  
def redirect_uri  
  uri = URI.parse(request.url)  
  uri.path = '/auth/test/callback'  
  uri.query = nil
  uri.to_s
end  
