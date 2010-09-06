module FacebookOAuth
  # FacebookObject
  #
  class FacebookObject
    # info
    #
    def info(options = {})
      unless options.empty?
        query = "?" + options.map {|k,v| [k.to_s,v.to_s].join("=")}.join("&") 
      end
      @client.send(:_get, "#{@oid}#{query}")
    end
  end
end