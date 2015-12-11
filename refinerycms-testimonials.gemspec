# Encoding: UTF-8

Gem::Specification.new do |s|
  s.name              = %q{refinerycms-testimonials}
  s.version           = %q{3.0.0}
  s.description       = %q{Ruby on Rails Testimonials extension for Refinery CMS}
  s.summary           = %q{Testimonials extension for Refinery CMS}
  s.email             = %q{info@refinerycms.com}
  s.homepage          = %q{http://github.com/refinery/refinerycms-page-images}
  s.require_paths     = %w(lib)
  s.license            = %q{MIT}
  s.authors           = %q{tsdbrown - Luke Brown- magpieuk, Lee Irving - http://www.transcendit.co.uk, anita - Anita Graham - http//:www.joli.com.au}

  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- spec/*`.split("\n")

  # Runtime dependencies
  s.add_dependency    %q{refinerycms}
  s.add_dependency    %q{decorators},        %q{~> 2.0.0}
  s.add_dependency    %q{globalize},         %q{~> 5.0}
  s.add_dependency    %q[randumb]
  s.add_dependency %q{friendly_id}, %q{~> 5.1.0}
  s.add_dependency %q{friendly_id-globalize}, %q{>= 1.0.0.alpha2}

  # Development dependencies (usually used for testing)
  s.add_development_dependency %q{refinerycms-testing}
end
