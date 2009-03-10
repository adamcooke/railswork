class RenameProgrammingJobsToTechnical < ActiveRecord::Migration
  def self.up
    jobs = Job.find(:all, :conditions => "category = 'Programming'")
    for job in jobs
      job.update_attribute('category', 'Technical')
    end
  end
  
  def self.down
  end
end
