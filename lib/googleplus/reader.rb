require 'googleplus/reader/version'

module GooglePlus
  module Reader
    if defined? ::Rails
      class Engine < ::Rails::Engine
      end
    end
  end
end
