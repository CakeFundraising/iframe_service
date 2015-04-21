class Fundraiser < ActiveRecord::Base
  has_many :campaigns, dependent: :destroy
  has_many :pledges, ->{ normal }, through: :campaigns
end