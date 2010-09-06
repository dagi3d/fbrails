FBRails
=======

A simple rails plugin to access the facebook user's data
It uses the facebook_oauth gem to make the authorized requests


Usage
=====

config/facebook.yml

    development:
      application_id: "APPLICATION_ID"
      application_secret: "APPLICATION_SECRET"
      locale: "es_ES"

      
config/initializers/facebook.rb
    
    FBRails::Config.load_configuration("#{Rails.root}/config/facebook.yml", Rails.env)

    
app/controllers/comments_controller.rb
    
    class CommentsController < ApplicationController
      # create
      #
      def create
        @comment = Comment.new(params[:comment])
        
        fb_data = facebook_session

        if fb_data
          @comment.facebook_uid    = fb_data['id']
          @comment.author_name     = fb_data['name']
          @comment.author_picture  = fb_data['picture']
        end
        
        ...
      end
    end
  
    
You can also ask for specific user fields:
    
    fb_data = facebook_session(:fields => "name,picture")
    
    
app/views/comments/new.html.haml
    
    <div id="fb-root">
    <fb:login-button></fb:login-button>
    </div>

    = facebook_connect_init(:status => true, :cookie => true, :xfbml =>true)


Issues
======

In case you get the error "SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed" you can try to pass it by changing the Faraday adapter: 
  
    Faraday.default_adapter = :typhoeus
    
Copyright (c) 2010 dagi3d, released under the MIT license
