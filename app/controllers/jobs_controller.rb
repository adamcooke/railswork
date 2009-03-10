class JobsController < ApplicationController
  before_filter :find_job, :except => [:index, :new, :create, :confirm, :latest, :ipn]
  before_filter :require_auth, :only => [:edit, :update, :remove, :destroy]
  
  def index
    @category = params[:category] ||= "all"
    @jobs = Job.find_jobs(@category)
    respond_to do |wants|
      wants.html
      wants.xml { render :xml => @jobs.to_xml(:only => Job::XML_FIELDS)}
      wants.rss { render :action => "rss", :layout => false }
      wants.js do
        render :update do |p|
          p << %Q{ RailsWork.Jobs.ActivateSubNav('#{@category}'); }
          p["jobs"].replace_html :partial => "jobs", :object => @jobs
        end
      end
    end
  end
  
  def ipn
    ppc = PaypalCallback.create(:callback_data => params, :txn_id => params[:txn_id], :payment_status => params[:payment_status], :status => Paypal.validate_callback(params))
    if ppc.valid?
      listing = Job.find(params[:item_number])
      listing.activate
      listing.save
      JobMailer.deliver_confirmation(listing)
      render :text => "Activated"
    else
      render :text => "Rejected"
    end
  end
  
  def edit
    @job.listing_password = params[:pw]
  end
  
  def update
    if @job.update_attributes(params[:job])
      respond_to do |wants|
        wants.html {redirect_to job_path(@job)}
        wants.xml { head :ok }
      end
    else
      respond_to do |wants|
        wants.html {render :action => "edit"}
        wants.xml { render :xml => @job.errors.to_xml, :status => :unprocessable_entity}
      end
    end
  end
  
  def new
    @job = Job.new
  end
  
  def create
    @job = Job.new(params[:job])
    if @job.save
      session["new_jobs"] = Array.new unless session["new_jobs"].is_a?(Array)
      session["new_jobs"] << @job.id
      respond_to do |wants|
        wants.html { redirect_to confirm_job_path(@job) }
        wants.xml { head :ok }
      end
    else
      respond_to do |wants|
        wants.html {render :action => "new" }
        wants.xml { render :xml => @job.errors.to_xml, :status => :unprocessable_entity, :location => @job }
      end
    end
  end
  
  def confirm
    @job = Job.find(params[:id])
    render_error(404) unless session["new_jobs"].include?(@job.id)
    #session["new_jobs"].delete(@job.id)
  end

  
  def destroy
    @job.destroy
    respond_to do |wants|
      wants.html { redirect_to home_path }
      wants.xml { head :ok }       
    end
  end
  
  def latest
    @job = Job.find(:first, :order => "created_at DESC", :conditions => "activated_at is not null")
    respond_to do |wants|
      wants.html { redirect_to job_path(@job) }
      wants.xml { render :xml => @job.to_xml(:only => Job::XML_FIELDS) }
    end
  end
  
  protected
  
  def find_job
    @job = Job.find_job(params[:id])
    render_error(404) and return if @job.blank?
  end
  
  def require_auth
    render_error(403) and return unless @job.editable?(params[:pw]) or admin?
  end

end
