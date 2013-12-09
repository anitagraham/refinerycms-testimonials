require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

end

Spork.each_run do
  # This code will be run each time you run your specs.

end

def setup_environment
  # Configure Rails Environment
  ENV["RAILS_ENV"] = 'test'

  unless ENV['COVERAGE'] || ENV['TRAVIS']
    require 'simplecov'
    SimpleCov.start 'rails'
  end

  if File.exist?(dummy_path = File.expand_path('../dummy/config/environment.rb', __FILE__))
    require dummy_path
  elsif File.dirname(__FILE__) =~ %r{vendor/extensions}
    # Require the path to the refinerycms application this is vendored inside.
    require File.expand_path('../../../../../config/environment', __FILE__)
  end

  require 'rspec/rails'
  require 'capybara/rspec'

  Rails.backtrace_cleaner.remove_silencers!

  Capybara.javascript_driver = :webkit

  RSpec.configure do |config|
    config.mock_with :rspec
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true

    # config.filter_run :js => true if ENV['JS'] == 'true'
    # config.filter_run :js => nil if ENV['JS'] == 'false'
    config.run_all_when_everything_filtered = true
    # config.include ActionView::TestCase::Behavior, :example_group => { :file_path => %r{spec/presenters} }
  end
end

def each_run
  if ENV['COVERAGE'] && !ENV['TRAVIS']
    require 'simplecov'
    SimpleCov.start 'rails'
  end

  Rails.cache.clear
  ActiveSupport::Dependencies.clear
  FactoryGirl.reload

  # Requires supporting files with custom matchers and macros, etc,
  # in ./support/ and its subdirectories including factories.
  ([Rails.root.to_s] | ::Refinery::Plugins.registered.pathnames).map{|p|
    Dir[File.join(p, 'spec', 'support', '**', '*.rb').to_s]
  }.flatten.sort.each do |support_file|
    require support_file
  end
end

# If spork is available in the Gemfile it'll be used but we don't force it.
unless (begin; require 'spork'; rescue LoadError; nil end).nil? || ENV['TRAVIS']
  Spork.prefork do
    # Loading more in this block will cause your tests to run faster. However,
    # if you change any configuration or code from libraries loaded here, you'll
    # need to restart spork for it take effect.
    setup_environment
  end

  Spork.each_run do
    # This code will be run each time you run your specs.
    each_run
  end
else
  setup_environment
  each_run
end


def build_testimonial(from, quote, date=Date.today)
  Refinery::Testimonials::Testimonial.create :name => from, :quote=>quote, :received_date=>date
end

def add_testimonial(from, quote)
  click_link ::I18n.t('create_new', :scope => 'refinery.testimonials.admin.testimonials.actions')
  fill_in "Name", :with => from
  page.execute_script("WYMeditor.INSTANCES[0].html('<p>#{quote}</p>')")
  click_button "Save"
end

def create_page(title)
  Refinery::Page.create :title => title
end


RSpec::Matchers.define :each do |meta|
  match do |actual|
    actual.each_with_index do |i, j|
      @elem = j
      i.should meta
    end
  end

  failure_message_for_should do |actual|
    "at[#{@elem}] #{meta.failure_message_for_should}"
  end
end


RSpec::Matchers.define :be_ordered_by do |attribute|
  match do |actual|
    result = true
    reverse_indicator = "_desc"
    if attribute =~ /#{reverse_indicator}/
      symbol = attribute.gsub(/#{reverse_indicator}/,'').to_sym
      sorted = actual.sort{ |a,b| b.send(symbol) <=> a.send(symbol)}
    else
      sorted = actual.sort{ |a,b| a.updated_at <=> b.updated_at}
    end
    sorted.each_with_index do |a,i|
      result = false unless actual[i] == a
    end
  result # return true or false for this matcher.
  end

  failure_message_for_should do |actual|
    "expected that #{actual} would be sorted by #{attribute}"
  end

  failure_message_for_should_not do |actual|
    "expected that #{actual} would not be sorted by #{attribute}"
  end

  description do
    "be a sorted by #{attribute}"
  end
end