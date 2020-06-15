# frozen_string_literal: true

module Refinery
  #:nodoc:
  module Testimonials
    include ActiveSupport::Configurable

    config_accessor :page_maximum, :page_url
    self.page_url = '/testimonials'
    self.page_maximum = 500 # maximum to display on a page
  end
end

