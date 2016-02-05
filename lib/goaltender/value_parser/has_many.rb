module Goaltender
  class ValueParser
    class HasMany < ValueParser
      attr_reader :form_class, :variable_name

      def after_init(args)
        @form_class = args[:form_class]
        @variable_name = args[:variable_name]
      end

      # should return a pattern like...
      # {
      #   loads_attributes: {
      #     "0" => {
      #       pays_fuel_surcharge: true,
      #       pickup_datetime: #datetime_object
      #     }
      #   }
      # }
      def parse
        return input_value unless input_value.present?
        hash = {}
        input_value.each do |index, obj_hash|
          object_hash = form_class.new(obj_hash).to_h
          hash[index] = object_hash
        end
        hash
      end
    end
  end
end
