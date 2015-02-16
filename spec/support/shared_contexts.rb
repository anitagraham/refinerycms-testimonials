shared_context 'always' do

end

shared_context 'Testimonials Tab' do
  let(:initial_path){refinery.admin_root_path}
end

# shared_context 'Exisitng testimonial' do
  # let(:existing_testimonial) {FactoryGirl.build(:testimonial, name: 'Update me', quote: 'quote')}
  # let(:initial_path) {refinery.edit_testimonial_path(page_for_testimonial) }
# end

shared_context 'Edit Page' do
  let(:test_page) {  FactoryGirl.create(:page,  title: 'Test Controls')}
end

shared_context 'Many Testimonials' do
  FactoryGirl.build_list(:testimonial, 8)
end

shared_context 'No Testimonials' do
  # Refinery::Testimonials::Testimonial.delete_all()
  # puts "There are #{Refinery::Testimonials::Testimonial.count} testimonials left."
end

shared_context 'Destroy Testimonial' do
  let(:initial_path){refinery.testimonials_admin_testimonials_path}
end
