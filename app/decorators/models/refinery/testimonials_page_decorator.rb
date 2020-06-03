# Open the Refinery::Page model for manipulation
Refinery::Page.class_eval do

  # valid_format_names = %w(full extract).freeze
  # valid_select_options = %w(recent random).freeze

  # validates :testimonials_format, inclusion: { in: valid_format_names,
  #                                              message: "%{value} must be one of %{valid_format_names}" }
  # validates :testimonials_select, inclusion: { in: valid_select_options,
  #                                              message: "%{value} must be one of %{valid_select_options}" }
  attr_reader :testimonials

  def testimonials
    return if @testimonials
    return unless testimonials_show
    testimonials = Refinery::Testimonials::Testimonial
    testimonials = testimonials.with_excerpt if testimonials_format == 'extract'
    testimonials = Refinery::Testimonials::Testimonial.random if testimonials_select == 'random'
    testimonials = Refinery::Testimonials::Testimonial.recent if testimonials_select == 'recent'
    testimonials = testimonials.limit(testimonials_count) unless (testimonials_count&.zero? || testimonials.count.zero?) # (or null)

    @testimonials = testimonials_format == 'extract' ? testimonials.map(&:extract) : testimonials
  end
end

