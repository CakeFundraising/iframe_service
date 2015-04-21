Rails.application.routes.draw do
  root to: redirect(CAKE::HOST)

  scope :badges, controller: :badges do
    get "campaign/:id", action: :campaign
    get "pledge/:id", action: :pledge
  end
end
