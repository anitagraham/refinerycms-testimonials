class RemoveTestimonialControlsFromPages < ActiveRecord::Migration[4.2]

  def change
    remove_column :refinery_pages, :testimonials_show, :boolean, if_exists: true
    remove_column :refinery_pages, :testimonials_count, :integer, if_exists: true
    remove_column :refinery_pages, :testimonials_select, :string, if_exists: true
    remove_column :refinery_pages, :testimonials_format, :string, if_exists: true
  end

end

