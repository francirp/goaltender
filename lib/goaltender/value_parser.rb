require 'goaltender/value_parser/belongs_to'
require 'goaltender/value_parser/boolean'
require 'goaltender/value_parser/date'
require 'goaltender/value_parser/datetime'
require 'goaltender/value_parser/float'
require 'goaltender/value_parser/has_many'
require 'goaltender/value_parser/integer'
require 'goaltender/value_parser/string'
require 'goaltender/value_parser/nil_class'
require 'goaltender/value_parser/attachment'

module Goaltender
  class ValueParser

    attr_accessor :input_value

    def initialize(args = {})
      @input_value = args[:input_value]
      after_init(args)
    end

    def parse
      # implemented by child classes
    end

    def after_init(args)
      # optionally implemented by child classes
    end

  end
end