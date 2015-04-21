class Campaign < ActiveRecord::Base
  include Picturable
  include Statusable

  has_statuses :incomplete, :pending, :launched, :past
  has_statuses :unprocessed, :missed_launch, column_name: :processed_status

  belongs_to :fundraiser
  has_many :pledges
  has_many :direct_donations, as: :donable

  monetize :goal_cents
  
  def accepted_pledges
    pledges.accepted.order(total_amount_cents: :desc, amount_per_click_cents: :desc)
  end

  #Click Analytics
  def total_donation_per_click
    pledges.accepted.sum(:amount_per_click_cents)/100.0
  end

  def current_pledges_total
    pledges.accepted.sum(:total_amount_cents)/100
  end

  def raised(status=:accepted)
    pledges.send(status).map(&:total_charge).sum.to_f
  end

  def raised_by_status
    status = self.launched? ? :accepted : self.status
    pledges.send(status).map(&:total_charge).sum.to_f
  end

  def current_average_donation
    return 0 unless pledges.accepted.any?
    (raised/pledges.accepted.count).floor
  end

  def pledges_thermometer
    (raised_by_status/goal.amount)*100 unless goal.amount == 0.0
  end

  #Direct Donation Analytics
  def donations_thermometer
    (donations_raised/goal.amount)*100 unless goal.amount == 0.0
  end

  def donations_raised
    direct_donations.map(&:amount).sum.to_f
  end

  def total_donations_and_clicks
    raised_by_status + donations_raised
  end

  def donation_clicks_thermometer
    (total_donations_and_clicks/goal.amount)*100 unless goal.amount == 0.0
  end

  #Popular
  def self.popular
    self.with_picture.with_pledges.not_past.not_incomplete.visible.latest.first(12)
  end

  #Status
  def active?
    end_date >= Date.today and status != 'past'
  end

  #Hero Campaign
  def hero_pledge?
    self.hero ? pledges.accepted_or_past.any? : false
  end

  def hero_pledge
    pledges.accepted_or_past.first if hero_pledge?
  end

end
