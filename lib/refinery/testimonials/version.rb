module Refinery
  module Testimonials
    class Version
      @major = 4
      @minor = 1
      @tiny  = 0

      class << self
        attr_reader :major, :minor, :tiny

        def to_s
          [@major, @minor, @tiny].compact.join('.')
        end
      end
    end
  end
end
