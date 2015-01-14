shared_context 'always' do
end

shared_context 'many testimonials' do
  # 8.times { FactoryGirl.create(:testimonial)}
end

shared_context 'Edit Page' do
  let(:test_page) {  FactoryGirl.create(:page,  title: 'Test Controls')}
end
