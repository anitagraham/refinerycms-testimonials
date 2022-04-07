# frozen_string_literal: true

module Refinery
  module Testimonials
    module Admin
      # Admin controller for Testimonials
      class TestimonialsController < ::Refinery::AdminController
        crudify :'refinery/testimonials/testimonial',
                include: [:translations],
                title_attribute: :flash_name,
                order: 'received_date DESC'
        private

        def testimonial_params
          params.require(:testimonial).permit(permitted_testimonial_params)
        end

        def permitted_testimonial_params
          %i[
            company
            display
            excerpt
            job_title
            name
            position
            quote
            received_channel
            received_date
            website
          ]
        end
      end
    end
  end
end
