class TranslateTestimonials < ActiveRecord::Migration
  def self.up
    Refinery::Testimonials::Testimonial.create_translation_table!({
      name: :string,
      quote: :text,
      teaser: :string,
      job_title: :string,
      website: :string
    }, {
      migrate_data: true
    })
  end

  def self.down
    Refinery::Testimonials::Testimonial.drop_translation_table! migrate_data: true
  end
end