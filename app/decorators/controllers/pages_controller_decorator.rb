Refinery::PagesController.class_eval do
  append_before_filter :get_testimonials, :only => [:show]
  protected

  def get_testimonials
    if @page.testimonials_show
      n = page.testimonials_count==0 ? Refinery::Testimonials::Testimonial.count : page.testimonials_count
      @testimonials = Refinery::Testimonials::Testimonial.scoped
      @testimonials = page.testimonials_select=='Random' ? @testimonials.random(n) : @testimonials.recent(n)
    end
  end
end