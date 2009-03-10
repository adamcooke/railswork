require 'net/http'
require 'uri'
module Paypal
  
  def self.validate_callback(params)
    url = "http://#{PAYPAL_CONFIG[:url]}"
    params[:cmd] = "_notify-validate"    
    res = Net::HTTP.post_form(URI.parse(url), params)
    return res.body
  end
  
end
