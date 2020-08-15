# frozen_string_literal: true

# Open the Refinery::Page model for manipulation
Refinery::Page.class_eval do
  def testimonials
    return unless testimonials_show

    count = testimonials_count.zero? ? Refinery::Testimonials.page_maximum : testimonials_count
    Refinery::Testimonials::Testimonial.i18n
      .short(testimonials_format.downcase)
      .random_selection(testimonials_select == 'random')
      .most_recent
      .limit(count)
  end
end

