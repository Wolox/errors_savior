require 'yaml'

module ErrorsSavior
  module Dictionary
    module LocalDictionary
      def errors_dictionary
        dictionary_path = File.join(__dir__, 'local_dictionary.yml')
        HashWithIndifferentAccess.new(YAML.safe_load(File.read(dictionary_path)))
      end

      def required_attributes
        %i[error_class error_code http_status_sym http_status_code message]
      end

      module_function :errors_dictionary, :required_attributes
    end
  end
end
