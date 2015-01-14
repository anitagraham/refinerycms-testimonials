Refinery::Admin::PagesController.class_eval do

  # work around an issue with stack level too deep, due to an issue with decorators.
  if self.instance_methods.exclude?(:page_params_with_testimonial_params)
    # We need to add testimonials attributes to page_params as it is ignored by strong parameters. (See #100)
    def page_params_with_testimonial_params

      # Get the :images_attributes hash from params
      testimonial_params = params.require(:page).permit(:testimonials_show, :testimonials_count, :testimonials_select)
      page_params_without_testimonial_params.merge(testimonial_params)

    end

    # Swap out the default page_params method with our new one
    alias_method_chain :page_params, :testimonial_params
  end
end
