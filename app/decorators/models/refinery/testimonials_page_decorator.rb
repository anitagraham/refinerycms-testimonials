# Open the Refinery::Page model for manipulation
Refinery::Page.class_eval do

  VALID_FORMAT_NAMES = %w(full extract).freeze
  VALID_SELECT_OPTIONS = %w(recent random).freeze

  validates :testimonials_format, inclusion: { in: VALID_FORMAT_NAMES,
                                               message: "%{value} must be one of %{valid_format_names}" }
  validates :testimonials_select, inclusion: { in: VALID_SELECT_OPTIONS,
                                               message: "%{value} must be one of %{valid_select_options}" }
  attr_reader :testimonials

  def testimonials
    return if @testimonials
    return unless testimonials_show
    testimonials = Refinery::Testimonials::Testimonial.random if testimonials_select == 'random'
    testimonials = Refinery::Testimonials::Testimonial.recent if testimonials_select == 'recent'
    testimonials = Refinery::Testimonials::Testimonial.with_excerpt if testimonials_format == 'extract'
    testimonials = testimonials.limit(testimonials_count) unless testimonials_count&.zero? # (or null)

    @testimonials = testimonials_format == 'extract' ? testimonials.map(&:extract) : testimonials
  end
end

