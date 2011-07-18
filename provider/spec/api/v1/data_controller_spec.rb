require "spec_helper"

describe "api/v1/data", :type => :api do
  fixtures :users, :client_applications
  let(:error) {"Invalid OAuth Request"}
  let(:token) {Oauth2Token.create(:client_application => client_applications(:one), :user=>users(:aaron)).token}

  context "invalid token" do

    context "show" do

      let(:url) { "api/v1/data" }
      it "JSON" do
        get "#{url}.json"
        last_response.body.should eql(error)
        last_response.status.should eql(401)
      end

      it "XML" do
        get "#{url}.xml"
        last_response.body.should eql(error)
        last_response.status.should eql(401)
      end

    end

  end

  context "valid token" do

    context "show" do

      let(:url) { "api/v1/data" }
      it "JSON" do
        get "#{url}.json", :oauth_token => token
        last_response.body.should eql({:super_secret => "oauth_data"}.to_json)
        last_response.status.should eql(200)
      end

      it "XML" do
        get "#{url}.xml", :oauth_token => token
        last_response.body.should eql({:super_secret => "oauth_data"}.to_xml)
        last_response.status.should eql(200)
      end

    end

  end

end


