module Goaltender
  class ValueParser
    class BelongsTo < ValueParser

      attr_reader :form_class, :variable_name

      def after_init(args)
        @form_class = args[:form_class]
        @variable_name = args[:variable_name]
      end

      def parse
        return input_value unless input_value.present?
        form_class.constantize.new(input_value).to_h
      end

    end
  end
end