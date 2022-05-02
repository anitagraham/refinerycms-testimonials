class AddTestimonialSelectionOptionToPages < ActiveRecord::Migration[4.2]

  def change
    unless ActiveRecord::Base.connection.column_exists?(:refinery_pages, :testimonials_format)
      change_table :refinery_pages do |t|
        t.string :testimonials_format, default: 'Full', if_not_exists: true
      end
    end
  end
end
