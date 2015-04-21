class DirectDonation < ActiveRecord::Base
  belongs_to :donable, polymorphic: true
  has_one :charge, as: :chargeable

  monetize :amount_cents
end
