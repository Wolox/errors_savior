require 'yaml'

module ErrorsSavior
  module Dictionary
    module LocalDictionary
      DEFAULT_LOCALE = :en

      module_function

      def errors_dictionary
        errors_savior_dictionary.merge!(external_errors_dictionary)
      end

      def required_attributes
        %i[error_code http_status_sym http_status_code message]
      end

      def errors_savior_dictionary
        dictionary_path = File.join(__dir__, '..', 'config', 'locale', "#{DEFAULT_LOCALE}.yml")
        read_dictionary(dictionary_path, DEFAULT_LOCALE)
      end

      def external_errors_dictionary
        locale = Config.locale
        external_dir = Config.external_dictionary_errors_path
        return {} if external_dir.empty?

        dictionary_path = File.join(Rails.root.join(external_dir, "#{locale}.yml"))
        read_dictionary(dictionary_path, locale)
      end

      def read_dictionary(dir, locale)
        HashWithIndifferentAccess.new(YAML.safe_load(File.read(dir)))[locale]
      end
    end
  end
end
