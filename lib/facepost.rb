require "facepost/version"
require "facepost/exceptions"
require 'rest_client'
require 'json'

module Facepost

  def self.create_album(page_uid, token, title)
    albums_url = "https://graph.facebook.com/#{page_uid}/albums"
    params = {:name => title, 
      :access_token => token, 
      :privacy => '{"value":"EVERYONE"}'}    
    begin  
      response = ::RestClient.post albums_url, params
    rescue RestClient::BadRequest 
      raise Facepost::BadRequest
    end
    hash = ::JSON.parse(response)
    hash["id"]
  end

end
