# Open the Refinery::Page model for manipulation
Refinery::Page.class_eval do

  # valid_format_names = %w(full extract).freeze
  # valid_select_options = %w(recent random).freeze

  # validates :testimonials_format, inclusion: { in: valid_format_names,
  #                                              message: "%{value} must be one of %{valid_format_names}" }
  # validates :testimonials_select, inclusion: { in: valid_select_options,
  #                                              message: "%{value} must be one of %{valid_select_options}" }
  attr_accessor :testimonials

  def testimonials
    count = testimonials_count.zero? ? 500 : testimonials_count
    return unless testimonials_show

    Refinery::Testimonials::Testimonial
      .random_order(testimonials_select=='random')
      .order(received_date: :desc)
      .format(testimonials_format)
      .limit(count)
  end
end

