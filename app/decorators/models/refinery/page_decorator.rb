# Open the Refinery::Page model for manipulation
Refinery::Page.class_eval do
  # Whitelist the testimonials control fields
  attr_accessor :testimonials
  attr_accessible :testimonials, :testimonials_show, :testimonials_count, :testimonials_select
  validates :testimonials_count, :numericality => { :only_integer => true, :greater_than_or_equal_to=>0 }
end