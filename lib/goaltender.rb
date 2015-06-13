require "goaltender/version"
require 'goaltender/base'

module Goaltender

  class << self
    def included(base)
      base.extend ClassMethods
    end
  end

  module ClassMethods
    def input(name, type = nil, options = {})
      @@input_definitions ||= {}
      array = @@input_definitions[self.name].present? ? @@input_definitions[self.name] : []
      array << [name, type, options]
      @@input_definitions[self.name] = array
    end

    def input_definitions
      @@input_definitions
    end
  end

end
