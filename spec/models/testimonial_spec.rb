require 'spec_helper'

module Refinery
  module Testimonials
    describe Testimonial, type: :model do

      let(:good_testimonial) { FactoryBot.create(:testimonial) }

      describe 'validations' do
        context "with all required attributes" do
          before do
            good_testimonial.valid?
          end
          it "has no errors" do
            expect(good_testimonial.errors).to be_empty
          end
          it "has a name" do
            expect(good_testimonial.name).to match(/Person Name \d+/)
          end
          it "has a quote" do
            expect(good_testimonial.quote).to match(/Like your work \d+/)
          end
        end

        context "without required attribute name" do
          subject { FactoryBot.build(:testimonial, name: "") }
          it 'fails validation' do
            expect(subject).not_to be_valid
            expect(subject.errors).to_not be_empty
          end
        end

        context "without required attribute quote" do
          subject { FactoryBot.build(:testimonial, quote: "") }
          it 'fails validation' do
            expect(subject).not_to be_valid
            expect(subject.errors).not_to be_empty
          end
        end
      end
    end
  end
end
