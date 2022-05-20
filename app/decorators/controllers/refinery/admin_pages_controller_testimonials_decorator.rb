Refinery::Admin::PagesController.prepend(
  Module.new do
    def permitted_page_params
      params[:page][:testimonial_ids].nil? ? {} : params[:page][:testimonial_ids].compact
      super << { testimonial_ids: [] }
    end
  end
)
