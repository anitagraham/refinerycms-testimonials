# frozen_string_literal: true

module Refinery
  module Testimonials
    # Model for Testimonials for RefineryCMS
    class Testimonial < Refinery::Core::BaseModel
      extend Mobility
      include Filterable

      self.table_name = 'refinery_testimonials'

      translates :quote, :excerpt
      default_scope { i18n }

      # Constants for how to show the testimonials
      ORDER = %w[Random Recent].freeze
      CHANNELS = %w[Letter Email Facebook Twitter].freeze

      CHANNELS.each_with_index do |meth, index|
        define_method("#{meth}?") { channels == index }
      end

      has_and_belongs_to_many :pages,
                              class_name: 'Refinery::Page',
                              join_table: 'refinery_pages_testimonials'

      validates :name, presence: true, uniqueness: true
      validates :quote, presence: true

      scope :has_excerpt?,      -> { where.not(excerpt: [nil,''])}
      scope :most_recent,       -> { order(received_date: :desc) }

      def self.filters
        %i[by_media]
      end

      filter_scope :by_media, -> (media_type) {CHANNELS}

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
