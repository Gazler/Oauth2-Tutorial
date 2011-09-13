require 'sinatra'  
require 'oauth2'  
require 'json'
enable :sessions
  
def client  
  OAuth2::Client.new(consumer_key, consumer_secret, :site => 'http://localhost:3000')  
end  

get '/auth/test' do  
  redirect client.web_server.authorize_url(  
    :redirect_uri => redirect_uri
  )  
end  
  
get '/auth/test/callback' do  
  access_token = client.web_server.get_access_token(params[:code], :redirect_uri => redirect_uri)  
  session[:access_token] = access_token.token
  @message = JSON.parse(access_token.get('/api/v1/data.json'))
  erb :success
end  

get '/another_page' do
  @message = get_response('data.json')
  erb :different
end

get '/a_different_page' do
  @message = get_response('data.json')
  erb :success
end
  
def get_response(url)
  access_token = OAuth2::AccessToken.new(client, "djfiodsjfoi")
  JSON.parse(access_token.get("/api/v1/#{url}")) 
end
  
def redirect_uri  
  uri = URI.parse(request.url)  
  uri.path = '/auth/test/callback'  
  uri.query = nil
  uri.to_s
end  

