shared_examples_for 'List of Testimonials' do

  before do
    raise "please set let(:initial_path)" if initial_path.blank?
    ensure_on(initial_path)
  end

  context 'when there are no testimonials' do
    it 'displays a message saying no testimonials' do
      expect(page).to have_content(::I18n.t('no_items_yet', scope: 'refinery.plugins.refinery_testimonials'))
    end
  end

  context 'when there are some testimonials' do
    it 'shows the title of each testimonial' do
      expect(page).to have_selector('span.title', count: Refinery::Testimonials::Testimonial.count)
    end
  end
end

shared_examples_for 'display tab' do
  before do
    raise "please set let(:initial_path)" if initial_path.blank?
    ensure_on(initial_path)
  end

  it 'shows the testimonials tab title' do
    expect(page).to have_content(::I18n.t('title', scope: 'refinery.plugins.refinery_testimonials'))
  end

  it 'has a testimonials tab' do
    expect(page).to have_selector('#plugin_refinery_testimonials')
  end

end #display tab

shared_examples_for 'shows "Add New Testimonial" link'  do

  before do
    raise "please set let(:initial_path)" if initial_path.blank?
    ensure_on(initial_path)
  end

  it 'Shows a link to add a testimonial' do
    within '#actions' do
      expect(page).to have_content(::I18n.t('create_new', :scope => 'refinery.testimonials.admin.testimonials.actions'))
    end
  end
  it 'has a path to the \'new testimonials\' action' do
    within '#actions' do
      expect(page).to have_selector("a[href='/refinery/testimonials/testimonials/new']")
    end
  end

end

shared_examples_for 'Display "no items" message' do
  before do
    raise "please set let(:initial_path)" if initial_path.blank?
    ensure_on(initial_path)
  end

  it 'Says there are no testimonials yet' do
    expect(page).to have_content(::I18n.t('no_items_yet', :scope => 'refinery.testimonials.admin.testimonials.records'))
  end

  it 'does not show any testimonials' do
    expect(page).not_to have_content()
  end
end

shared_examples_for 'Show "Reorder testimonials" link' do
  before do
    raise "please set let(:initial_path)" if initial_path.blank?
    ensure_on(initial_path)
  end

  it 'has a path to the reorder testimonials action' do
    within '#actions' do
      expect(page).to have_selector("a[href='/refinery/testimonials/testimonials']")
    end
  end

  it 'has a link to reorder the testimonials' do
    within '#actions' do
      expect(page).to have_content(::I18n.t('reorder', :scope => 'refinery.testimonials.admin.testimonials.actions'))
    end
  end
end

shared_examples_for 'Add a testimonial' do
  let(:adding_a_testimonial) {|from, quote|
  -> {
    click_link ::I18n.t('create_new', :scope => 'refinery.testimonials.admin.testimonials.actions')
    fill_in "Name", :with => from
    page.execute_script("WYMEditor.INSTANCES[0].html('<p>#{quote}</p>')")
    click_button "Save"
    }
  }


  before do
    raise "please set let(:initial_path)" if initial_path.blank?
    ensure_on(initial_path)
  end

  it 'displays a success message' do
    add_testimonial('My first Testimonial', 'Quote')
    expect(page).to have_content("'Quote by My first Testimonial' was successfully added.")
  end

  it 'adds actions for the new testimonial' do
    add_testimonial('My first Testimonial', 'Quote')
#       need to locate these for the exact testimonial
    expect(page.html).to include('Remove this testimonial forever')
    expect(page.html).to include('Edit this testimonial')
    expect(page.html).to include('/refinery/testimonials/testimonials/1/edit')
  end

  expect(adding_a_testimonial).to change(Refinery::Testimonials::Testimonial.count).by(1)

end

shared_examples_for 'Edit and update a testimonial' do
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

shared_examples_for 'Destroy' do
  context 'When a testimonial can be deleted' do
    before do
      build_testimonial('Delete me', 'Quote me')
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