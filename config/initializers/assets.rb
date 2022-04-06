
if Rails.application.config.respond_to?(:assets)
  Rails.application.config.assets.precompile << 'refinery_testimonials_manifest.js'
end
