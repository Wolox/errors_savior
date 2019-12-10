require 'yaml'

module ErrorsSavior
  module Dictionary
    module LocalDictionary
      def errors_dictionary
        dictionary_path = File.join(__dir__, 'local_dictionary.yml')
        HashWithIndifferentAccess.new(YAML.safe_load(File.read(dictionary_path)))
      end

      module_function :errors_dictionary
    end
  end
end
