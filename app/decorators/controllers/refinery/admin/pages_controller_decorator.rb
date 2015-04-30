Refinery::Admin::PagesController.prepend(
  Module.new do
    def permitted_page_params
      super <<  [:testimonials_show, :testimonials_count, :testimonials_select]
    end
  end
)
