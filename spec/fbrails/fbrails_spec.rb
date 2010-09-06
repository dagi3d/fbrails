require File.expand_path('./../../spec_helper', __FILE__)

describe "FBRails" do
  
  before(:each) do
    #FBRails::Config.stub(:application_id, "W")
  end
  
  it "should load a configuration file" do
    FBRails::Config.load_configuration(File.join(File.dirname(__FILE__), "../facebook.yml"))
    FBRails::Config[:application_id].should == "APPLICATION_ID"
    FBRails::Config[:application_secret].should == "APPLICATION_SECRET"
  end
  
end

class FacebookController < ActionController::Base
  def index
    render :text => ""
  end
end

describe FacebookController do
  include RSpec::Rails::ControllerExampleGroup
  
  before(:each) do
    FBRails::Config.load_configuration(File.join(File.dirname(__FILE__), "../facebook.yml"))
  end
  
  context "the facebook cookie is set" do
    before(:each) do
      cookie_value = '"access_token=125199480861838|2.oAgfHFO_vwpxqZ9cCVFbmg__.3600.1282615200-1128841670|FWxUhgVvmoRH9AT7oHNsF9RUXUk.&expires=1282615200&secret=mbEfaM6X54fOJRM32JtxZQ__&session_key=2.oAgfHFO_vwpxqZ9cCVFbmg__.3600.1282615200-1128841670&sig=dc47db848029dff2a13cf26136d0f00b&uid=1128841670"'
    end
    
    it "should retrieve the logged user information" do
      post "/"
    end
  end
end