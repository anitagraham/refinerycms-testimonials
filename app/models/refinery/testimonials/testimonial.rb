module Refinery
  module Testimonials
    class Testimonial < Refinery::Core::BaseModel
      self.table_name = "refinery_testimonials"

      # Constants for how to show the testimonials
      ORDER = %w[Random Recent]
      CHANNELS = %w[Letter Email Facebook Twitter]

      CHANNELS.each_with_index do |meth, index|
        define_method("#{meth}?") { channels == index }
      end

      attr_accessible :name, :quote, :company, :job_title, :website, :received_date, :received_channel, :position, :display

      acts_as_indexed :fields => [:name, :company]

      validates :name, :presence => true, :uniqueness => true
      validates :quote, :presence => true

      scope :recent, lambda { |n| order('created_at DESC').limit(n)}
      scope :random, lambda { |n| order('RAND()').limit(n)}

      def flash_name
        "Quote by #{self.name}"
      end

    end
  end
end
