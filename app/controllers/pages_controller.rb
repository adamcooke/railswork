
class PagesController < ApplicationController
  
  def free
  end
  
  def about
  end
  
  def terms
  end
  
  def community_listings
  end
  
  def method_missing(c)
    render_error(404)
  end
  
end
