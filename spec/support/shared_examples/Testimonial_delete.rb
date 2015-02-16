shared_examples_for 'Allows a testimonial to be deleted' do
  context 'When a testimonial can be deleted' do
    before do
      FactoryGirl.build(:testimonial, name: 'Delete me', quote: 'Quote me')
    end

    it 'Will show delete button' do
      within '.record' do
        expect(page.html).to include(::I18n.t('delete', :scope => 'refinery.testimonials.admin.testimonials.testimonial'))
        expect(page).to have_selector("a[href='/refinery/testimonials/testimonials/1']")
      end
    end

    it 'Will delete the testimonial' do
      click_link 'Remove this testimonial forever'

      expect(page).to have_content("'Quote by Delete me' was successfully removed.")
      expect(Refinery::Testimonials::Testimonial.count).to eq(0)
    end
  end
end