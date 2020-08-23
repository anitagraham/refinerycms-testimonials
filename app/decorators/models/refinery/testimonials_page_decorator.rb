# frozen_string_literal: true

# Open the Refinery::Page model for manipulation
Refinery::Page.class_eval do
  def testimonials
    return unless testimonials_show

    count = testimonials_count.zero? ? Refinery::Testimonials.page_maximum : testimonials_count

    testimonials = Refinery::Testimonials::Testimonial.i18n
    testimonials = testimonials.has_excerpt? if testimonials_format == 'excerpt'
    testimonials = testimonials.random_selection if testimonials_select.downcase == 'random'
    testimonials = testimonials.most_recent if testimonials_select.downcase == 'recent'
    @testimonials = testimonials.limit(count)
  end
end

