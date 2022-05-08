# frozen_string_literal: true

module Refinery
  module Testimonials
    # Controller for Testimonials
    class TestimonialsController < ::ApplicationController
      def index
        @testimonials = Testimonial.all.includes(:translations)
      end
    end
  end
end
