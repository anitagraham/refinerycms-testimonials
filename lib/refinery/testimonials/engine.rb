 module Refinery
  module Testimonials
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Testimonials

      engine_name :refinery_testimonials

      def self.register_testimonials(tab)
        tab.name = 'testimonials'
        tab.partial = '/refinery/testimonials/admin/testimonials/tabs/testimonial_control'
      end

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = 'refinery_testimonials'
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.testimonials_admin_testimonials_path }
          plugin.pathname = root
          plugin.menu_match = %r{refinery/testimonials/testimonials}
          plugin.activity = {
            :class_name => Refinery::Testimonials::Testimonial,
            :title =>  'name'
          }
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Testimonials)
        Refinery::Pages::Tab.register do |tab|
          register_testimonials tab
        end
        require 'refinery/testimonial_item_presenter'
      end
    end
  end
end
