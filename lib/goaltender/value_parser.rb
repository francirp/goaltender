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