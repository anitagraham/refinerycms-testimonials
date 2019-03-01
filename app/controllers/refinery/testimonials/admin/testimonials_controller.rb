module Refinery
  module Testimonials
    module Admin
      class TestimonialsController < ::Refinery::AdminController

        crudify :'refinery/testimonials/testimonial',
                :title_attribute => :flash_name, :xhr_paging => true

        private
        def testimonial_params
          params.require(:testimonial).permit(permitted_testimonial_params)
        end

        def permitted_testimonial_params
          [:name,
           :quote,
           :company,
           :job_title,
           :website,
           :received_date,
           :received_channel,
           :position,
           :display]
        end
      end
    end
  end
end
