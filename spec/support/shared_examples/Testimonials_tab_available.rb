shared_examples_for 'Testimonials Tab Available' do
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

end