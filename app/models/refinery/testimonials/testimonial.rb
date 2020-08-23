# frozen_string_literal: true

module Refinery
  module Testimonials
    # Model for Testimonials for RefineryCMS
    class Testimonial < Refinery::Core::BaseModel
      extend Mobility
      self.table_name = 'refinery_testimonials'

      translates :quote, :excerpt
      default_scope { i18n }

      # Constants for how to show the testimonials
      ORDER = %w[Random Recent].freeze
      CHANNELS = %w[Letter Email Facebook Twitter].freeze

      CHANNELS.each_with_index do |meth, index|
        define_method("#{meth}?") { channels == index }
      end

      validates :name, presence: true, uniqueness: true
      validates :quote, presence: true

      scope :random_selection,  -> { order(Arel.sql('RANDOM()'))}
      scope :has_excerpt?,      -> { where.not(excerpt: [nil,''])}
      scope :most_recent,       -> { order(received_date: :desc) }

      def flash_name
        "Quote by #{name}"
      end

      warning do |testimonial|
        testimonial.warnings.add(:excerpt, ": No excerpt written") unless testimonial.excerpt.present?
        testimonial.warnings.add(:received_date, ": No date") unless testimonial.received_date
      end
    end
  end
end
