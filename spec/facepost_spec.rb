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

  describe "List pages" do
    
    before(:each) do
      page_1_json = '{"category":"Artist",
      "name":"Page1",
      "access_token":"123asd",
      "id":"609925135690770",
      "perms":["ADMINISTER","EDIT_PROFILE","CREATE_CONTENT","MODERATE_CONTENT","CREATE_ADS","BASIC_ADMIN"]}'

      page_2_json = '{"category":"Artist",
      "name":"Page2",
      "access_token":"123asd",
      "id":"609925135690770",
      "perms":["ADMINISTER","EDIT_PROFILE","CREATE_CONTENT","MODERATE_CONTENT","CREATE_ADS","BASIC_ADMIN"]}'

      @accounts_url = /https:\/\/graph.facebook.com\/me\/accounts.*/
      payload = "{\"data\":[#{page_1_json}, #{page_2_json}]}"
      stub_request(:get, @accounts_url).to_return(:body => payload)
    end
    
    
    it "should return a list of the pages" do
      page1 = {:name => "Page1", :token => "123asd", :uid => "609925135690770"}
      page2 = {:name => "Page2", :token => "123asd", :uid => "609925135690770"}
      pages = Facepost.list_pages("token")
      pages.should include(page1)
      pages.should include(page2)
    end
  end

end