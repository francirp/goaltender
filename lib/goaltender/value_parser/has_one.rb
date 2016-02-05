module Goaltender
  class ValueParser
    class HasOne < ValueParser
      attr_reader :form_class, :variable_name

      def after_init(args)
        @form_class = args[:form_class]
        @variable_name = args[:variable_name]
      end

      # should return a pattern like...
      # {
      #   document_attributes: {
      #     name: "Name of doc",
      #     date: #datetime_object
      #   }
      # }
      def parse
        return input_value unless input_value.present?
        form_class.new(input_value).to_h
      end
    end
  end
end
