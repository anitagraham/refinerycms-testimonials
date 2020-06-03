require 'spec_helper'

module Refinery
  module Testimonials
    describe Testimonial, type: :model do

      let(:good_testimonial)     { FactoryBot.create(:testimonial)}
      let(:no_name_testimonial)  { FactoryBot.create(:testimonial, name: "") }
      let(:no_quote_testimonial) { FactoryBot.create(:testimonial, quote: "")}

      describe 'validations' do
        context "with all required attributes" do
          it "has no errors" do
            expect(good_testimonial.errors).to  be_empty
          end
          it "has a name" do
            expect(testimonial.name).to  eq('Person Name')
          end
          it "has a quote" do
            expect(testimonial.quote).to eq('Like your work')
          end
        end

        context "without required attribute name" do
          it 'fails validation' do
            expect(no_name_testimonial).not_to be_valid
          end
          it "has errors" do
            expect(no_name_testimonial.errors).not_to be_empty
          end
        end
        context "without required attribute quote" do
          it 'fails validation' do
            expect(no_quote_testimonial).not_to be_valid
          end
          it "has errors" do
            expect(no_name_testimonial.errors).not_to be_empty
          end
        end
      end
    end
  end
end
