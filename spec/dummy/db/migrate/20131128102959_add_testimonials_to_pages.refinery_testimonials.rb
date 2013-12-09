# This migration comes from refinery_testimonials (originally 2)
class AddTestimonialsToPages < ActiveRecord::Migration

  def change
    change_table :refinery_pages do |t|
      t.boolean :testimonials_show, :default => false
      t.integer :testimonials_count, :default => 0
      t.string :testimonials_select, :default => 'Random'
    end
  end

end
