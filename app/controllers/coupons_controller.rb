class CouponsController < ApplicationController
  before_filter :require_admin
  before_filter :get_coupon, :except => [:index, :new, :create]
  
  def index
    @coupons = Coupon.find(:all, :order => "code")
  end
  
  def new
    @coupon = Coupon.new
  end
  
  def create
    @coupon = Coupon.new(params[:coupon])
    if @coupon.save
      flash[:notice] = "Coupon has been added successfully"
      redirect_to coupons_path
    else
      render :action => "new"
    end
  end
  
  def update
    if @coupon.update_attributes(params[:coupon])
      flash[:notice] = "Coupon has been saved successfully"
      redirect_to coupons_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @coupon.destroy
    flash[:notice] = "Coupon has been deleted successfully"
    redirect_to coupons_path
  end
  
  protected
  
  def get_coupon
    @coupon = Coupon.find(params[:id])
  end
  
end
