# Open the Refinery::Page model for manipulation

Refinery::Page.class_eval do
  attr_accessor :testimonials
  validates :testimonials_count, :numericality => { :only_integer => true, :greater_than_or_equal_to=>0 }

  def testimonials
    if testimonials_show
      n = testimonials_count==0 ? Refinery::Testimonials::Testimonial.count : testimonials_count
      @testimonials = Refinery::Testimonials::Testimonial.all
      @testimonials = testimonials_select=='Random' ?
          @testimonials.order_by_rand.limit(n) :
          @testimonials.order('created_at DESC').limit(n)
    end
  end
end