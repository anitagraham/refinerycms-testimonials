module Refinery
  module Testimonials
    include ActiveSupport::Configurable

    config_accessor  :page_url
    self.page_url    = '/testimonials'
  end
end

