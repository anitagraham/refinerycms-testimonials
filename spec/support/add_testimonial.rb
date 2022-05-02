def add_testimonial(name, quote)
  visit refinery.testimonials_admin_testimonials_path
  click_link 'Add New Testimonial'
  fill_in 'testimonial_name', with: name
  fill_in 'testimonial_quote', with: quote
  click_button "Save"
end

