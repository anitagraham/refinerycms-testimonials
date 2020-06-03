
FactoryBot.define do
  factory :testimonial, class: Refinery::Testimonials::Testimonial do
    sequence name { |n| "Person Name #{n}" }
    sequence quote { |n| "Like your work #{n}" }
  end
end

