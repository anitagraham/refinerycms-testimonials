module PageTestimonialsDecorator
  def self.prepended(base)
    base.has_and_belongs_to_many :testimonials,
                                 class_name: "Refinery::Testimonials::Testimonial",
                                 join_table: 'refinery_pages_testimonials'
  end

  Refinery::Page.prepend PageTestimonialsDecorator
end

