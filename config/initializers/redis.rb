unless Rails.env.test?
  redis_url = ENV["REDISTOGO_URL"] || "redis://localhost:6379/0/cake_iframe"

  IframeService::Application.config.cache_store = :redis_store, redis_url
  IframeService::Application.config.session_store :redis_store, redis_server: redis_url
end