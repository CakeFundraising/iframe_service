class PledgeDecorator < ApplicationDecorator
  delegate_all
  decorates_association :campaign
  decorates_association :sponsor
  decorates_association :fundraiser
  decorates_association :picture
  
  def to_s
    object.name
  end

  def class_name
    object.class.name
  end

  def instance_name
    class_name.downcase
  end

  def end_date
    campaign.end_date
  end

  def cause
    object.campaign.main_cause
  end

  def scopes
    object.campaign.scopes
  end

  def scope
    scopes.first
  end

  def total_amount
    h.humanized_money_with_symbol object.total_amount
  end

  def amount_per_click
    h.humanized_money_with_symbol object.amount_per_click
  end

  def total_charge
    h.humanized_money_with_symbol object.total_charge
  end

  def fundraiser_name(length)
    h.truncate(object.fundraiser.name, length: 36)
  end

  def sponsor_name(length)
    h.truncate(object.sponsor.name, length: 36)
  end

  def status
    object.status.titleize
  end

  def website
    h.auto_attr_link website_url, target: :_blank
  end

  def website_url
    (object.website_url=~/^https?:\/\//).nil? ? "http://#{object.website_url}" : object.website_url
  end

  ##impressions
  def engagement
    "#{object.engagement}%"
  end

  def click_path
    object.instance_of?(Pledge) ? h.click_pledge_path(object) : h.click_quick_pledge_path(object)
  end

  def shareable_screenshot_url
    object.screenshot_url.split('url2png').join('url2png/w_1200,h_600,c_fill,g_north,r_10') unless object.screenshot_url.blank?
  end
end
