require 'spec_helper'
describe Facepost do

  describe "Creating an Album as a Page" do
    
    context "when publishing returns success" do
      before(:each) do
        stub_request(:post, "https://graph.facebook.com/123456/albums").
          with(:body => {:name=>"Album Title", 
                         :access_token => "token", 
                         :privacy => '{"value":"EVERYONE"}'}).
          to_return(:status => 200, 
                    :body => "{\"id\":\"7777777777\"}", 
                    :headers => {})
      end

      it "should return the facebook_id of the album" do
       Facepost.create_album("123456", "token", "Album Title").should == "7777777777"
      end


      # it "should update the facebook_published_at timestamp" do
      #   Timecop.freeze(Time.now)
      #   publish
      #   @album.reload
      #   @album.facebook_published_at.should == DateTime.now
      # end

    end
    
  end


end