module Refinery
  module PageTestimonialsDecorator
    def self.prepended(base)
      base.has_many :appearances, class_name: '::Refinery::Testimonials::Appearance'
      base.has_many :testimonials, -> { order(received_date: :desc).distinct },
                    through: :appearances,
                    class_name: "Refinery::Testimonials::Testimonial",
                    inverse_of: :pages
    end
  end
end
Refinery::Page.prepend Refinery::PageTestimonialsDecorator
