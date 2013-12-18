require 'spec_helper'

module Refinery
  module Testimonials
    describe Testimonial do

      let(:testimonial) { FactoryGirl.build(:testimonial) }
      let(:created_testimonial) { FactoryGirl.create(:testimonial) }

      context "with valid attributes" do
        it "should report being valid" do
          expect(testimonial.valid?).to be_true
        end
      end

      describe 'validations' do

        it  'should be_valid'  do

          expect(testimonial.errors).to  be_empty
          expect(testimonial.name).to  eq('Person Name')
          expect(testimonial.quote).to eq('Like your work')
        end

        invalid_testimonial =  Factory.build(:testimonial, :name=> '')

        it 'should_not be_valid' do
          expect(invalid_testimonial).not_to be_valid
          expect(invalid_testimonial.errors).not_to be_empty
        end

        invalid_testimonial = Factory.build(:testimonial, :quote => '')
         it 'should_not be_valid' do
           expect(invalid_testimonial).not_to be_valid
           expect(invalid_testimonial.errors).not_to be_empty
         end

      end
    end
  end
end