class JobObserver < ActiveRecord::Observer
  
  def after_create(m)
    JobMailer.deliver_confirmation(m) if m.amount_payable <= 0
  end
  
end