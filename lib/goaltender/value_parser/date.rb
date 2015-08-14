module Goaltender
  class ValueParser
    class Date < ValueParser

      attr_reader :input_format

      def after_init(args)
        @input_format = args[:input_format] || "%m/%d/%Y"
      end

      def parse
        return input_value unless input_value.present?
        return input_value if input_value.is_a?(Date)
        ::Date.strptime(input_value, input_format)
      end

    end
  end
end