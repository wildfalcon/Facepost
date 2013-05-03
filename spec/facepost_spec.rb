require 'spec_helper'
describe Facepost do

  describe "Creating an Album as a Page" do

    def publish
      Facepost.create_album("123456", "token", "Album Title")
    end

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

      it "should return the facebook_uid of the album" do
        publish.should == "7777777777"
      end

    end


    context "when publishing returns an error" do
      before(:each) do
        stub_request(:post, "https://graph.facebook.com/123456/albums").
        with(:body => {:name=>"Album Title", :access_token => "token", :privacy => '{"value":"EVERYONE"}'}).
        to_raise(RestClient::BadRequest)          
      end

      it "Should raise an error" do
        expect{ publish }.to raise_error(Facepost::BadRequest)
      end

    end



  end

  describe "Posting Photo to Album as a Page" do
    
    def publish
      Facepost.post_photo("123456", "token", Tempfile.new(".tmp"))
    end
    
    context "when publishing returns success" do
      before(:each) do
        stub_request(:post, "https://graph.facebook.com/123456/photos").
          to_return(:status => 200, :body => "{\"id\":\"7777777777\"}", :headers => {})         
      end

      it "should return the facebook_uid of the photo" do
        publish.should == "7777777777"
      end


    end
    
    context "when publishing returns an error" do
      before(:each) do
        stub_request(:post, "https://graph.facebook.com/123456/photos").
        to_raise(RestClient::BadRequest)          
      end

      it "should raise an error" do
        expect{publish}.to raise_error(Facepost::BadRequest)
      end

    end
    
  end

end