module Refinery
  module Testimonials
      class TestimonialsController < ::ApplicationController
      respond_to :json, :html
      crudify :'refinery/testimonials', order: 'received_date DESC'
      end
    end
end
