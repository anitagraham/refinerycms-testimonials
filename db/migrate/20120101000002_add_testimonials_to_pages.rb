class AddTestimonialsToPages < ActiveRecord::Migration[4.2]

  def change
    unless ActiveRecord::Base.connection.column_exists?(:refinery_pages, :testimonials_show)
      change_table :refinery_pages do |t|
        t.boolean :testimonials_show, :default => false, if_not_exists: true
        t.integer :testimonials_count, :default => 0, if_not_exists: true
        t.string :testimonials_select, :default => 'Random', if_not_exists: true
      end
    end
  end

end
