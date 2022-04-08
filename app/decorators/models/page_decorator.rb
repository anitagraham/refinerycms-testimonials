# Open the Refinery::Page model for manipulation

Refinery::Page.class_eval do
  has_and_belongs_to_many :testimonials,
                          class_name: "Refinery::Testimonials::Testimonial",
                          join_table: 'refinery_pages_testimonials'

end

