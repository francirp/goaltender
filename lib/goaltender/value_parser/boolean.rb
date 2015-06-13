module Goaltender
  class ValueParser
    class Boolean < ValueParser

      def parse
        return false unless input_value.present?
        return true if input_value == "1"
        return true if input_value == true
        return true if input_value == "true"
        return false
      end

    end
  end
end