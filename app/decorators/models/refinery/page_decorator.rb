# Open the Refinery::Page model for manipulation

Refinery::Page.class_eval do
  # Whitelist the testimonials control fields
  attr_accessor :testimonials
  attr_accessible :testimonials, :testimonials_show, :testimonials_count, :testimonials_select
  validates :testimonials_count, :numericality => { :only_integer => true, :greater_than_or_equal_to=>0 }

  def testimonials
    if testimonials_show
      n = testimonials_count==0 ? Refinery::Testimonials::Testimonial.count : testimonials_count
      @testimonials = Refinery::Testimonials::Testimonial.scoped
      @testimonials = testimonials_select=='Random' ? random(n) : recent(n)
    end
  end
end