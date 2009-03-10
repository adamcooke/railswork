class Coupon < ActiveRecord::Base
  
  TYPES = [["Percentage", "percent"], ["Fixed Value", "amount"]]
  
  ## Validations
  
  validates_presence_of :code, :discount_type, :amount
  
end
