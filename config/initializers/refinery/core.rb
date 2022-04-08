Refinery::Core.configure do |config|
  # # Register extra javascripts and stylesheets for backend
  config.register_visual_editor_javascript "refinery/testimonials/testimonials"
  config.register_visual_editor_stylesheet "refinery/testimonials/refinery-testimonials.css"
end
#
# Rails.application.config.assets.precompile += %w( refinerycms-testimonials.css multi.js refinerycms-testimonials.js )
#
