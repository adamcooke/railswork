class JobMailer < ActionMailer::Base

  def confirmation(job)
    @subject      =   'Your RailsWork Listing is Active'
    @body["job"]  =   job
    @recipients   =   job.contact_email
    @from         =   'Rails Work <do-not-reply@railswork.com>'
    @sent_on      =   Time.now
    @headers      =   {}
  end
  
end
