module Refinery
  module Testimonials
    class Version
      @major = 4
      @minor = 0
      @tiny  = 2

      class << self
        attr_reader :major, :minor, :tiny

        def to_s
          [@major, @minor, @tiny].compact.join('.')
        end
      end
    end
  end
end
