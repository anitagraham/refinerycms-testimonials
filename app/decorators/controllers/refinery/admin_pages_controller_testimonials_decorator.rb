module Refinery
  module AdminPagesControllerTestimonialsDecorator
    protected

      def permitted_page_params
        super << [testimonial_ids: []]
      end
  end

  Refinery::Admin::PagesController.send :prepend, AdminPagesControllerTestimonialsDecorator
end
