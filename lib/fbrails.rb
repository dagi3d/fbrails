# Fbrails
module FBRails
  module ControllerMethods
    
    def self.included(receiver) # :nodoc:
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
    
    module ClassMethods
    end
      
    module InstanceMethods
      # facebook_session
      #
      def facebook_session(options = {}, access_token = nil)
        access_token = access_token_from_cookie if access_token.nil?
        return if access_token.nil?
                
        begin
          client = FacebookOAuth::Client.new(
              :application_id => FBRails::Config[:application_id],
              :application_secret => FBRails::Config[:application_secret],
              :token => access_token
          ).me.info(options)
        rescue
        end
      end
      
      private
      def application_cookie
        cookie_name = "fbs_" + FBRails::Config[:application_id]
        cookie = request.cookies[cookie_name]
        return if cookie.nil?
        
        keys_values = cookie.gsub(/"/, '').split("&").map {|value| value.split("=")}.flatten
        Hash[*keys_values]
      end
      
      def access_token_from_cookie
        cookie = application_cookie
        return if cookie.nil?
        
        cookie['access_token']
      end
    end
  end
  
  module ViewMethods
    def facebook_connect_init(options = {})
      init_options = {
        :appId => FBRails::Config[:application_id]
      }.merge(options).to_json
      
      locale = FBRails::Config[:locale]
      out = javascript_include_tag("http://connect.facebook.net/#{locale}/all.js") 
      out += "\n"
      out += content_tag("script", "FB.init(#{init_options})".html_safe)
      out
    end
  end
  
  class Config
    
    def self.load_configuration(file, env)
      @@configuration = {
        :locale => "en_US"
      }.merge(YAML.load(File.read(file))[env])
    end
    
    def self.[](field_name)
      @@configuration[field_name.to_s]
    end
  end
end