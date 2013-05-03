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

  def self.post_photo(album_uid, token, photo, caption = nil)
      photo_url = "https://graph.facebook.com/#{album_uid}/photos"

      params = {
        :source => photo, 
        :access_token => token,
        :name => caption
      }
      begin
        response = RestClient.post photo_url, params
      rescue RestClient::BadRequest
        raise Facepost::BadRequest
      end
      hash = JSON.parse(response)
      hash["id"]
  end

end
