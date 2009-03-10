class DeactivateLaunchPromo < ActiveRecord::Migration
  def self.up
    coupon = Coupon.find_by_code('LAUNCH-PROMO')
    if coupon
      coupon.expired = true
      coupon.save
    end
  end

  def self.down
    coupon = Coupon.find_by_code('LAUNCH-PROMO')
    if coupon
      coupon.expired = false
      coupon.save
    end
  end
end
