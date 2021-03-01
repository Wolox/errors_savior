module ErrorsSavior
  module Config
    DEFAULT_CONFIG = {
      api_origin: nil,
      external_dictionary_errors_path: '',
      locale: :en
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
