version = Refinery::Testimonials::Version.to_s
Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-testimonials'
  s.version           = version
  s.description       = 'Ruby on Rails Testimonials extension for Refinery CMS'
  s.date              = '2019-02-16'
  s.summary           = 'Testimonials extension for Refinery CMS'
  s.require_paths     = %w[lib]
  s.files             = Dir['{app,config,db,lib}/**/*'] + ['readme.md']
  s.authors           = 'tsdbrown - Luke Brown- magpieuk, Lee Irving - http://www.transcendit.co.uk, anita - Anita Graham - http//:www.joli.com.au'

  # Runtime dependencies
  s.add_dependency 'actionmailer',      '>= 5.1'
  s.add_dependency 'refinerycms-core',  ['>= 3.0.0', '< 5.0']
  # s.add_dependency 'refinerycms-acts-as-indexed'

  s.required_ruby_version = '>= 2.2.2'
end
