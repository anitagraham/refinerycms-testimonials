
if Rails.application.config.respond_to?(:assets)
  Rails.application.config.assets.precompile << 'refinerycms_testimonials_manifest.js'
end
