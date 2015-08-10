class Goaltender::Base

  if Rails.version[0].to_i < 4
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming
  else
    include ActiveModel::Model
  end

  include Goaltender::BaseModule

  attr_reader :params, :inputs
  attr_accessor :inputs

  def initialize(args)
    @params = HashWithIndifferentAccess.new(args)
    @inputs = set_inputs
    after_init(@params)
  end

  def to_h
    hash = {}
    inputs.each do |input|
      value = instance_variable_get("@#{input.variable_name}")
      hash[input.variable_name] = value
    end
    hash
  end

  def save
    before_save
    success = valid_form? ? persist! : false
    if success
      after_save
      true
    else
      false
    end
  end

  private

    def set_inputs
      current_class_name = self.class.name
      relevant_classes = [current_class_name]
      classes = current_class_name.split("::")
      while classes.present?
        classes.pop
        possibility = classes.join("::")
        relevant_classes << possibility unless possibility.exclude?("::")
        current_class_name = possibility
      end

      all_inputs = []
      Goaltender::Base.input_definitions.each do |class_name, form_inputs|
        if relevant_classes.include?(class_name)
          form_inputs.each do |form_input|
            name = form_input[0]
            type = form_input[1]
            options = form_input[2]
            input_value = params[name]
            input = Goaltender::Input.new(self, name, type, input_value, options)
            self.class.__send__(:attr_accessor, input.variable_name)
            instance_variable_set("@#{input.variable_name.to_s}", input.parsed_value)
            all_inputs << input
          end
        end
      end
      all_inputs
    end

    def valid_form?
      valid? && object.valid?
    end

    def persist!
      object.save
    end

    # METHODS FOR CHILDREN

    def after_init(args)
      # this method is optionally implemented by children to
      # override default initialization behavior
    end

    def object
      # optionally implemented by children
    end

    def after_save
      # optionally implemented by children
    end

    def before_save
      # optionally implemented by children
    end

end