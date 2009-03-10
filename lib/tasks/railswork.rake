namespace :railswork do
  
  desc "Clean up Active Record sessions updated before ENV['EXPIRE_AT'] (defaults to 3 weeks ago)."
  task :clean_sessions => :environment do
    time = ENV['EXPIRE_AT'] || 3.weeks.ago.to_s(:db)
    rows = CGI::Session::ActiveRecordStore::Session.delete_all ["updated_at < ?", time]
    RAILS_DEFAULT_LOGGER.info "#{rows} session row(s) deleted."
  end

  
  desc "Remove un-activated entries after 5 days of inactivity"
  task :remove_inactive_jobs => :environment do
    
    jobs = Job.find(:all, :conditions => ["activated_at is null and created_at < ?", 5.days.ago])
    jobs.each do |job|
      RAILS_DEFAULT_LOGGER.info "#{rows} session row(s) deleted." "Removing Job ##{job.id}"
      job.destroy
    end    
  end
  
  desc "Run the above tasks every night in a nice single task"
  task :nightly => [:clean_sessions, :remove_inactive_jobs]
  
end