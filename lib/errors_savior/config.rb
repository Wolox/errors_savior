module ErrorsSavior
  module Config
    DEFAULT_CONFIG = {
      api_origin: nil
    }.freeze

    module_function

    DEFAULT_CONFIG.each do |key, value|
      define_method key do
        instance_variable_get("@#{key}") || instance_variable_set("@#{key}", value)
      end

      define_method "#{key}=" do |v|
        instance_variable_set("@#{key}", v)
      end
    end
  end
end
