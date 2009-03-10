class PaypalCallback < ActiveRecord::Base
  serialize :callback_data
  
  def valid?
    return false unless payment_status == "Completed"
    return false unless status == "VERIFIED"
    return false unless callback_data[:business] == PAYPAL_CONFIG[:business_email]
    ## TODO: validate with Paypal
    return true
  end
  
end
