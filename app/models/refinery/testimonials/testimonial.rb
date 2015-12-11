require 'randumb'

module Refinery
  module Testimonials
    class Testimonial < Refinery::Core::BaseModel
      self.table_name = "refinery_testimonials"

      translates :name, :quote, :teaser, :job_title, :website

      # Constants for how to show the testimonials
      ORDER = %w[Random Recent]
      CHANNELS = %w[Letter Email Facebook Twitter]

      CHANNELS.each_with_index do |meth, index|
        define_method("#{meth}?") { channels == index }
      end

      acts_as_indexed :fields => [:name, :company]

      validates :name, :presence => true, :uniqueness => true
      validates :quote, :presence => true

      def flash_name
        "Quote by #{self.name}"
      end

    end
  end
end
