module CampaignsHelper
  def campaign_url(campaign)
    "#{CAKE::HOST}/campaigns/#{campaign.id}"
  end

  def pledge_url(pledge)
    "#{CAKE::HOST}/pledges/#{pledge.id}"
  end
end