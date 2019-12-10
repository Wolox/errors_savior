module ErrorsSavior
  module Saviors
    class BaseSavior
      # self.abstract_class = true

      class << self
        def error_sym
          raise 'SubclassResponsibility'
        end

        def errors_dictionary
          ErrorsSavior::Dictionary::LocalDictionary.errors_dictionary
        end

        def error_class
          errors_dictionary[error_sym][__method__].constantize.name
        end

        def error_code
          errors_dictionary[error_sym][__method__].to_i
        end

        def http_status_sym
          errors_dictionary[error_sym][__method__].to_sym
        end

        def http_status_code
          errors_dictionary[error_sym][__method__].to_i
        end

        def message
          errors_dictionary[error_sym][__method__]
        end
      end
    end
  end
end
