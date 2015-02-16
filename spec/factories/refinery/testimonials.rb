FactoryGirl.define do
  # caller.each do |c|
    # puts '...' << c
  # end
  # puts '............'
  factory :testimonial, :class => Refinery::Testimonials::Testimonial do
    sequence(:name)  { |n| "Person Name #{n}" }
    sequence(:quote) { |n| "like your work #{n}"}
    sequence(:received_date)  { |n|  n.days.since   }
  end

end

