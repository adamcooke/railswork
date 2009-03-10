class Job < ActiveRecord::Base
  
  XML_FIELDS = [:category, :company_name, :company_url, :title, :description, :salary_range, :location, :id, :created_at]
  CATEGORIES = ["Technical","Design", "Other", "Community"]
  LISTING_LENGTHS = [["10 days at $0", 0, 10], ["30 days at $0", 0, 30]]

  attr_protected :expires_at, :password, :cost, :discount, :activated_at, :created_at
  attr_accessor :listing_password, :coupon_code
  
  ## Validations
  
  validates_presence_of :category, :title, :company_name, :location, :contact_email, :description, :application_instructions
  validates_format_of :contact_email, :with => /\A\b[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b\z/i, :unless => Proc.new {|j|j.contact_email.blank?}
  validates_format_of :company_url, :with => /\Ahttps?:\/\/[\w.]*\z/i, :unless => Proc.new{|j| j.company_url.blank?}
  
  ## Callbacks
  
  before_create :generate_password, :set_costs
  
  ## Acts
  
  acts_as_textiled :description, :application_instructions
  acts_as_ferret :fields => { :title => {:boost => 2, :store => :yes},
                              :description => {:store => :yes},
                              :company_name => {:store => :yes},
                              :location => {:store => :yes}
                            }
  
  ## Methods
  
  def editable?(password)
    self.password == password
  end
  
  def set_costs
    self.cost = Job::LISTING_LENGTHS.select {|k| k[2] == self.listing_length}[0][1]
    self.discount = 0
    self.coupon_code = self.coupon_code.upcase
    coupon = Coupon.find_by_code_and_expired(self.coupon_code, false)
    if coupon
      self.discount = coupon.discount_type == "amount" ? coupon.amount : ((self.cost / 100) * coupon.amount.to_i)
      coupon.uses += 1
      coupon.expired = true unless coupon.global?
      coupon.save
    end
    
    self.discount = 0 if self.discount < 0
    self.activate unless self.amount_payable > 0
  end
  
  def activate
    self.activated_at = Time.now
    self.expires_at = self.created_at + self.listing_length.days
  end
  
  class << self
    def find_job(id)
      find(:first, :conditions => ["id = ? and expires_at > ? and activated_at is not null", id, Time.now])
    end
    
    def find_jobs(category = '')
      category.blank? or category == 'all' ? find(:all, :conditions => ["expires_at > ? and activated_at is not null", Time.now], :order => "created_at DESC")  : find(:all, :conditions => ["category = ? and expires_at > ?", category, Time.now], :order => "created_at DESC")
    end
  end
  
  def amount_payable
    cost - discount
  end
  
  def active?
    !self.activated_at.blank?
  end
  
  def generate_password
    p = [title, location, Time.now, object_id, Time.now.to_s].join(",")
    self.password = Digest::SHA1.hexdigest(p)[0, 11]
  end
  
  def to_param
    [id, PermalinkFu.escape(self.title)].join("-")
  end
  
  def full_title
    %Q{ #{company_name} is looking for a #{title} in #{location} }
  end
    
end
