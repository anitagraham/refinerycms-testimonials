module PageTestimonialsPermitted
  def permitted_page_params
    params[:page][:testimonial_ids].nil? ? {} : params[:page][:testimonial_ids].compact
    super << { testimonial_ids: [] }
  end
end

module PageTestimonialsCollection
  private

    def find_all_testimonials
      @testimonials = Refinery::Testimonials::Testimonial.order(created_at: :desc).all
    end
end

Refinery::Admin::PagesController.prepend PageTestimonialsPermitted
Refinery::Admin::PagesController.prepend PageTestimonialsCollection
Refinery::Admin::PagesController.prepend_before_action :find_all_testimonials, only: :edit
