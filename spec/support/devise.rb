require 'refinery/testing'
RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.extend  ::Refinery::Testing::ControllerMacros::Authentication, :type => :controller
  config.extend  ::Refinery::Testing::FeatureMacros::Authentication, :type => :request

end