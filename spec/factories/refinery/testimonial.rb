
FactoryBot.define do
  sequence :name do |n|
    "Person Name #{n}"
  end

  sequence :quote do |n|
    "Like your work #{n}"
  end

  factory :testimonial, class: 'Refinery::Testimonials::Testimonial' do
    name
    quote
  end
end
