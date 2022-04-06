module AdminPagesControllerDecorator

    private
      def permitted_page_params
        super <<  [testimonial_ids: []]
      end

  end

Refinery::Admin::PagesController.send :prepend, AdminPagesControllerDecorator
