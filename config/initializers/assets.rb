Refinery::Core.configure do |config|
  # Register extra javascript for backend
  config.register_javascript "refinerycms-testimonials.js"

  # Register extra stylesheet for backend (optional options)
  config.register_stylesheet "refinerycms-testimonials", :media => 'screen'
end
Rails.application.config.assets.precompile += %w( refinerycms-testimonials.css refinerycms-testimonials.js )