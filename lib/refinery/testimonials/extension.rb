module Refinery
  module Testimonials
    module Extension

    end
  end
end

ActiveRecord::Base.send(:extend, Refinery::Testimonials::Extension)
