module Refinery
  module Testimonials
    module Admin
      class TestimonialsController < ::Refinery::AdminController

        crudify :'refinery/testimonials/testimonial',
        include: [:translations],
                title_attribute: :flash_name

        private
        def testimonial_params
          params.require(:testimonial).permit(permitted_testimonial_params)
        end

        def permitted_testimonial_params
          [
           :company,
           :display,
           :excerpt,
           :job_title,
           :name,
           :position,
           :quote,
           :received_channel,
           :received_date,
           :website
          ]
        end
      end
    end
  end
end
