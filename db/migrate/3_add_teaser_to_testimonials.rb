class AddTeaserToTestimonials < ActiveRecord::Migration

  def change
    change_table :refinery_testimonials do |t|
      t.string :teaser
    end
  end

end
