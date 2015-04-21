class Pledge < ActiveRecord::Base
  include Picturable
  
  belongs_to :campaign
  belongs_to :sponsor, polymorphic: true
  has_one :fundraiser, through: :campaign
  
  def current_max_clicks
    (self.total_amount_cents/self.amount_per_click_cents).floor
  end

  def thermometer
    (clicks_count.to_f/max_clicks)*100
  end

  #Invoices
  def total_charge
    clicks_count*amount_per_click
  end

  ### Impressions
  def views_count
    impressions_count || 0
  end

  def engagement
    return 0 if views_count.zero?
    (clicks_count/views_count)
  end

  def total_impressions
    views_count + bonus_clicks_count + clicks_count
  end

  ### Delegates
  def main_cause
    campaign_main_cause if campaign.present?
  end
  
  def active?
    campaign_active? if campaign.present?
  end

  def hero
    campaign_hero if campaign.present?
  end

  #Coupons & News
  def coupons_sample
    self.coupons.latest.limit(2)
  end

  def news_sample
    self.pledge_news.latest.first
  end

  def coupon_extra_clicks
    self.coupons.to_a.sum(&:extra_clicks_count)
  end

  def pledge_news_extra_clicks
    self.pledge_news.to_a.sum(&:extra_clicks_count)
  end

end
