
shared_examples_for 'Allows a testimonial to be edited' do
  before do
    raise "please set let(:initial_path)" if initial_path.blank?
    ensure_on(initial_path)
  end

  describe 'when saving and returning to index' do
    it 'updates testimonial', :js => true do
      expect(page).to have_content('Update me')
      click_link 'Edit this testimonial'

      fill_in 'Name', with:  'Updated'
      click_button 'Save'

      expect(page).to have_content("'Quote by Updated' was successfully updated.")
    end
  end
end