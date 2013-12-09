# This migration comes from refinery_testimonials (originally 1)
class CreateTestimonials < ActiveRecord::Migration

  def up
    create_table :refinery_testimonials do |t|
      t.string  :name
      t.text    :quote
      t.string  :company
      t.string  :job_title
      t.string  :website
      t.date    :received_date
      t.string  :received_channel
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-testimonials"})
    end

    drop_table :refinery_testimonials

  end

end
