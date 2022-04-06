class CreatePagesTestimonials < ActiveRecord::Migration[4.2]

  def up
    create_table :refinery_pages_testimonials do |t|
      t.references :page
      t.references :testimonial
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-testimonials"})
    end

    drop_table :refinery_pages_testimonials

  end

end
