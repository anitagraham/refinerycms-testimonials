require 'refinerycms-core'

module Refinery
  autoload :TestimonialsGenerator, 'generators/refinery/testimonials_generator'

  module Testimonials
    require 'refinery/testimonials/engine'
    require 'refinery/testimonials/configuration'

    autoload :Tab, 'refinery/testimonials/tabs'
    class << self
      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join('spec', 'factories').to_s ]
      end

      def tabs
        @tabs ||= []
      end

    end
  end
end
