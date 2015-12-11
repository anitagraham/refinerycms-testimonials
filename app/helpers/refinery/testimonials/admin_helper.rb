module Refinery
  module Testimonials
    module AdminHelper
      def title_with_translations(record)
        record.name.presence || record.translations.detect { |t| t.title.present?}.name
      end
    end
  end
end