module Goaltender
  class Input

    attr_accessor :current_instance, :name, :type, :parse_format, :default, :form_path, :form_class, :input_value, :variable_name

    def initialize(current_instance, name, type, input_value, options = {})
      @current_instance = current_instance
      @name = name
      @default = perform_default(options[:default])
      @input_value = input_value || @default
      @type = type || input_value.class
      @parse_format = options[:parse_format]
      @form_path = options[:form_path]
      @form_class = generate_form_class
      @variable_name = options[:variable_name] || @name
    end

    def value_parser
      @value_parser ||= "Goaltender::ValueParser::#{type.to_s.classify}".constantize.new({
        input_value: input_value,
        parse_format: parse_format,
        form_class: form_class,
        variable_name: variable_name
      })
    end

    def parsed_value
      @parsed_value ||= value_parser.parse
    end

    def generate_form_class
      return nil unless form_path
      folders = form_path.split("/").map(&:classify)
      classify_path = folders.join("::")
      return "Forms::#{classify_path}"
    end

    def perform_default(default_value)
      if default_value.is_a?(Symbol)
        current_instance.send(default_value)
      else
        default_value
      end
    end

  end
end