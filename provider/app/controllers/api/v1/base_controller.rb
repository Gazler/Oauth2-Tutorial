class Api::V1::BaseController < ApplicationController
  respond_to :json, :xml
  oauthenticate :interactive=>false
end
