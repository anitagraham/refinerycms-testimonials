class AddExcerptToTestimonials < ActiveRecord::Migration[6.0]

  def change
    change_table :refinery_testimonials do |t|
      t.text :excerpt
    end
  end

end
