class BadgesController < ApplicationController
  def campaign
    @campaign = Campaign.find(params[:id]).decorate
  end

  def pledge
    @pledge = Pledge.find(params[:id]).decorate
  end

end