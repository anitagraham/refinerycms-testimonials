shared_examples_for 'an index' do
 before do
    raise "please set let(:initial_path)" if initial_path.blank?
    ensure_on(initial_path)
  end

  it 'shows the title of each testimonial' do
    expect(page).to have_selector('span.title', count: Refinery::Testimonials::Testimonial.count)
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
end  # Testimonials Index