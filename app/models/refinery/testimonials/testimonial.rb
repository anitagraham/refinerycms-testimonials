module Refinery
  module Testimonials
    class Testimonial < Refinery::Core::BaseModel
      extend Mobility
      self.table_name = "refinery_testimonials"

      translates  :quote, :excerpt
      # Constants for how to show the testimonials
      ORDER = %w[Random Recent].freeze
      CHANNELS = %w[Letter Email Facebook Twitter].freeze

      CHANNELS.each_with_index do |meth, index|
        define_method("#{meth}?") { channels == index }
      end

      validates :name, presence: true, uniqueness: true
      validates :quote, presence: true

      # scope :choose_by, -> ( om) {  om === 'recent' ? self.recent : self.random  }
      scope :format, -> (exc) { where.not(excerpt: ["", nil]) if exc === 'extract'}

      def recent
        Rails.logger.debug(". . . . #{__FILE__}/#{__method__}looking for recent testimonials")
        order( received_at: :desc)
      end

      # def random
      #   order(Arel.sql('RANDOM()'))
      # end
      def flash_name
        "Quote by #{self.name}"
      end

    end
  end
end
