Refinery::Admin::PagesController.prepend(
  Module.new do
    def permitted_page_params
      super << %i[
        testimonials_show
        testimonials_count
        testimonials_select
        testimonials_format]
    end
  end
)
