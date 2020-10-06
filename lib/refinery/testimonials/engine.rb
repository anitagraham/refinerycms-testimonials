# frozen_string_literal: true

module Refinery
  module Testimonials
    # Standard Rails Engine
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery::Testimonials

      engine_name :refinery_testimonials

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = 'refinery_testimonials'
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.testimonials_admin_testimonials_path }
          plugin.pathname = root
          plugin.menu_match = %r{refinery/testimonials/testimonials(/.*)?$}
        end
      end

      def self.register_testimonials(tab)
        tab.name = 'testimonials'
        tab.partial = '/refinery/testimonials/admin/testimonials/tabs/testimonial_control'
      end

      config.after_initialize do
        tabs = [
          { title: 'Testimonial', partial: 'visual_editor_text', fields: [:quote] },
          { title: 'Excerpt',     partial: 'visual_editor_text', fields: [:excerpt] },
          { title: 'Client Details', partial: 'visual_editor_string_fields',
            fields: %i[company position job_title website] }

        ]
        tabs.each do |t|
          Refinery::Testimonials::Tab.register do |tab|
            tab.name = t[:title]
            tab.partial = "/refinery/testimonials/admin/testimonials/tabs/#{t[:partial]}"
            tab.fields = t[:fields]
          end
        end

        # We have a tab in the Page editor as well
        Refinery::Pages::Tab.register do |tab|
          register_testimonials tab
        end
        Refinery.register_extension(Refinery::Testimonials)
        require 'refinery/pages/testimonial_item_presenter'
      end
    end
  end
end
