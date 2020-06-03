module Refinery
  module Testimonials
    class Testimonial < Refinery::Core::BaseModel
      self.table_name = "refinery_testimonials"

      # Constants for how to show the testimonials
      ORDER = %w[Random Recent].freeze
      CHANNELS = %w[Letter Email Facebook Twitter].freeze

      CHANNELS.each_with_index do |meth, index|
        define_method("#{meth}?") { channels == index }
      end

      acts_as_indexed fields: [:name, :company]
      validates :name, presence: true, uniqueness: true
      validates :quote, presence: true

      scope :random, -> {  order(Arel.sql('RANDOM()'))}
      scope :recent, -> { order('created_at DESC') }
      scope :with_excerpt, -> { where.not(excerpt: ["", nil]) }

      def extract
        {
          id: id,
          name: name,
          quote: excerpt
        }
      end

      def flash_name
        "Quote by #{self.name}"
      end

    end
  end
end
