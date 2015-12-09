shared_examples_for 'Allows a testimonial to be added' do

  def add_testimonial(from, quote)
    click_link ::I18n.t('create_new', :scope => 'refinery.testimonials.admin.testimonials.actions')
    fill_in "Name", :with => from
    page.execute_script("WYMEditor_0.html('<p>#{quote}</p>')")
    click_button "Save"
  end

  before do
    raise "please set let(:initial_path)" if initial_path.blank?
    ensure_on(initial_path)
  end

  let(:adding_a_testimonial) {|from, quote|
  -> {
    click_link ::I18n.t('create_new', :scope => 'refinery.testimonials.admin.testimonials.actions')
    fill_in "Name", :with => from
    page.execute_script("WYMEditor_0.html('<p>#{quote}</p>')")
    click_button "Save"
    }
  }

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

  it 'displays a success message', js: true do
    add_testimonial('My first Testimonial', 'Quote')
    expect(page).to have_content("'Quote by My first Testimonial' was successfully added.")
  end

  it 'adds actions for the new testimonial', js: true do
    add_testimonial('My first Testimonial', 'Quote')
#       need to locate these for the exact testimonial
    expect(page.html).to include('Remove this testimonial forever')
    expect(page.html).to include('Edit this testimonial')
    expect(page.html).to include('/refinery/testimonials/testimonials/1/edit')
  end

  it 'saves a new testimonial', js: true do
    expect(adding_a_testimonial('Name', 'Quote')).to change(Refinery::Testimonials::Testimonial.count).by(1)
  end

end
