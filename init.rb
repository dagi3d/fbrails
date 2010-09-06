require File.join(File.dirname(__FILE__), "lib/fbrails")
require File.join(File.dirname(__FILE__), "lib/facebook_oauth")

ActionController::Base.send :include, FBRails::ControllerMethods
ActionView::Base.send       :include, FBRails::ViewMethods
