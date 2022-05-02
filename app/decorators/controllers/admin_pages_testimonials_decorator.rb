module AdminPageTestimonialsDecorator

  protected
      def get_testimonials
        @testimonials ||= Refinery::Testimonials::Testimonial.most_recent
      end

      def permitted_page_params
        super << [testimonial_ids: []]
      end

  end

Refinery::Admin::PagesController.send :prepend, AdminPageTestimonialsDecorator
Refinery::Admin::PagesController.class_eval do
  before_action :get_testimonials, only: [:edit]
end
