shared_examples_for 'No Testimonials Shown' do
  before do
    raise "please set let(:initial_path)" if initial_path.blank?
    ensure_on(initial_path)
  end

  it 'displays a message saying no testimonials' do
    expect(page).to have_content(::I18n.t('no_items_yet', scope: 'refinery.testimonials.admin.testimonials.records'))
  end
end