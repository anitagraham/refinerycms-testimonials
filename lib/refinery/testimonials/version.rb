module Refinery
  module Testimonials
    class Version
      @major = 4
      @minor = 0
      @tiny  = 0
      @build = ''

      class << self
        attr_reader :major, :minor, :tiny, :build

        def to_s
          [@major, @minor, @tiny, @build].compact.join('.')
        end
      end
    end
  end
end
