module Refinery
  module Testimonials
      class TestimonialsController < ::ApplicationController
      respond_to :json, :html
        def show
          @testimonial = Refinery::Testimonials::Testimonial.find(params[:id])
        end
      end
    end
end
