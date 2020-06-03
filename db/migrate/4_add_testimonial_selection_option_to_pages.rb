class AddTestimonialSelectionOptionToPages < ActiveRecord::Migration[4.2]

  def change
    change_table :refinery_pages do |t|
      t.string :testimonials_format, default: 'Full'
    end
  end

end
