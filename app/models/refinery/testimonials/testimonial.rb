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

      scope :random_selection, ->(really) { order(Arel.sql('RANDOM()')) if really }
      scope :short,            ->(format) { where.excerpt? if format.downcase == 'excerpt' }
      scope :most_recent,      -> { order(received_date: :desc) }

      def flash_name
        "Quote by #{name}"
      end

      def excerpt?
        excerpt.present?
      end

      warning do |testimonial|
        testimonial.warnings.add(:excerpt, ": No excerpt written") unless testimonial.excerpt?
      end
    end
  end
end
