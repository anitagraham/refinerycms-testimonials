# frozen_string_literal: true

module Refinery
  #:nodoc:
  class TestimonialsGenerator < Rails::Generators::Base
    def rake_db
      rake 'refinery_testimonials:install:migrations'
    end

    def append_load_seed_data
      unless File.exist?(File.join(destination_root, 'db', 'seeds.rb'))
        create_file 'db/seeds.rb'
      end
      append_file 'db/seeds.rb', verbose: true do
        <<~EOH
          
          # Added by Refinery CMS Testimonials extension
          Refinery::Testimonials::Engine.load_seed
        EOH
      end
    end
  end
end
