class Refinery::Testimonials::Appearance < Refinery::Core::BaseModel
  belongs_to :page, class_name: 'Refinery::Page'
  belongs_to :testimonial, class_name: 'Refinery::Testimonials::Testimonial'
  attribute :format
end
