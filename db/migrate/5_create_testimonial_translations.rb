class CreateTestimonialTranslations < ActiveRecord::Migration[6.0]
  def change
    create_table :refinery_testimonial_translations do |t|

      # Translated attribute(s)
      t.text :quote
      t.text :excerpt

      t.string  :locale, null: false
      t.references :refinery_testimonial, null: false, foreign_key: true, index: false

      t.timestamps null: false
    end

    add_index :refinery_testimonial_translations, :locale, name: :index_refinery_testimonial_translations_on_locale
    add_index :refinery_testimonial_translations, [:refinery_testimonial_id, :locale], name: :index_testimonial_t10s_on_testimonial_id_and_locale, unique: true

  end
end
