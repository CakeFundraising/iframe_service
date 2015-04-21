class Sponsor < ActiveRecord::Base
  has_many :pledges, as: :sponsor, dependent: :destroy
  has_many :campaigns, through: :pledges
end
