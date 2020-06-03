Refinery::Core.configure do |config|
  # Register extra javascripts and stylesheets for backend
  config.register_javascript "refinerycms-testimonials.js"
  config.register_stylesheet "refinerycms-testimonials.css"
end

Rails.application.config.assets.precompile += %w( refinerycms-testimonials.css refinerycms-testimonials.js )
