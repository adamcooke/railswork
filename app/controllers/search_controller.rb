class SearchController < ApplicationController
  
  def index
    redirect_to home_path and return if params[:q].blank?
    @results = Job.find_by_contents(params[:q])
    @results = @results.select {|k| k.active? }
    @total_hits = @results.size
    if @total_hits == 1
      flash[:notice] = "There was only result for your search so we've taken you straight to the relevant page, hope that's alright with you."
      redirect_to job_path(@results[0])
    end
  end
  
end
