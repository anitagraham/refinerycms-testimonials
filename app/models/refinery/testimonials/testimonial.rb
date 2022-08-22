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

      has_many :appearances, class_name: 'Refinery::Testimonials::Appearance'
      has_many :pages, -> { distinct },
               through: :appearances,
               class_name: 'Refinery::Page',
               inverse_of: :testimonials

      accepts_nested_attributes_for :appearances

      validates :name, presence: true, uniqueness: true
      validates :quote, presence: true

      scope :has_excerpt?, -> { where.not(excerpt: [nil,''])}
      scope :recent,       -> { order(received_date: :desc) }

      def self.filters
        %i[by_media]
      end

      filter_scope :by_media, -> (media_type) {Refinery::Testimonials.media}

      def flash_name
        "Quote by #{name}"
      end

      def select_option
        co = company.present? ? company.bracket : nil
        [name, co, received_date&.strftime('%b, %Y')].compact.join(' ').html_safe
      end

      def select_option_classes
        warnings.attribute_names unless sensible?
      end

      def status
        sensible? ? 'OK' : 'warning'
      end

      warning do |testimonial|
        testimonial.warnings.add(:excerpt, ": No excerpt written") unless testimonial.excerpt.present?
        testimonial.warnings.add(:received_date, ": No date") unless testimonial.received_date
      end
    end
  end
end
