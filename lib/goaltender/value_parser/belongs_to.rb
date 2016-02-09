module Goaltender
  class ValueParser
    class BelongsTo < ValueParser
      include Goaltender::ValueParser::Relationship

      def parse
        return input_value unless input_value.present?
        transformer.new(input_value).transform
      end
    end
  end
end
