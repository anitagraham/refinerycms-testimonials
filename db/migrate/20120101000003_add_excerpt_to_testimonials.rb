class AddExcerptToTestimonials < ActiveRecord::Migration[6.0]

  def change
    unless ActiveRecord::Base.connection.column_exists?(:refinery_testimonials, :excerpt)
      change_table :refinery_testimonials do |t|
        t.text :excerpt, if_not_exists: true
      end
    end
  end
end
