require 'spec_helper'

module Refinery
  module Testimonials
    describe Testimonial do

      let(:testimonial) { FactoryGirl.build(:testimonial) }
      let(:created_testimonial) { FactoryGirl.create(:testimonial) }

      context "with valid attributes" do
        it "should report being valid" do
          expect(testimonial.valid?).to be true
        end
      end

      describe 'validations' do

        it  'should be_valid'  do

          expect(testimonial.errors).to  be_empty
          expect(testimonial.name).to  match('Person Name \d{1,3}')
          expect(testimonial.quote).to match('Like your work \d{1,3}')
        end

        invalid_testimonial =  FactoryGirl.build(:testimonial, :name=> '')

        it 'should_not be_valid' do
          expect(invalid_testimonial).not_to be_valid
          expect(invalid_testimonial.errors).not_to be_empty
        end

        invalid_testimonial = FactoryGirl.build(:testimonial, :quote => '')
         it 'should_not be_valid' do
           expect(invalid_testimonial).not_to be_valid
           expect(invalid_testimonial.errors).not_to be_empty
         end

      end
    end
  end
end