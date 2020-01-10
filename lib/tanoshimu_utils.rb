require 'active_support'
require 'tanoshimu_utils/version'

module TanoshimuUtils
  class Error < StandardError
    def initialize(message = nil)
      message ||= 'Unknow error.'
      super("[TanoshimuUtils-#{VERSION}]: #{message}")
    end
  end
end

require 'tanoshimu_utils/railtie'
require_relative 'tanoshimu_utils/concerns'
require_relative 'tanoshimu_utils/validators'
