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


      scope :random_order, -> (really) { order(Arel.sql('RANDOM()')) if really }
      scope :format, -> (exc) { where.not(excerpt: ["", nil]) if exc === 'extract'}
      scope :most_recent, -> () { order(received_at: :desc)}

      # def random
      #   order(Arel.sql('RANDOM()'))
      # end
      def flash_name
        "Quote by #{self.name}"
      end

    end
  end
end
