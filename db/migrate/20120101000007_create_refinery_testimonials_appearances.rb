class CreateRefineryTestimonialsAppearances < ActiveRecord::Migration[4.2]

  def up
    create_table :refinery_testimonials_appearances, if_not_exists: true do |t|
      t.references :page
      t.references :testimonial
      t.string :format
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-testimonials"})
    end

    drop_table :refinery_testimonial_appearances

  end

end
