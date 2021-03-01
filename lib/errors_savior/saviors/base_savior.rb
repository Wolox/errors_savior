module ErrorsSavior
  module Saviors
    module BaseSavior
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def error_class_name
          raise 'SubclassResponsibility'
        end

        def errors_dictionary
          ErrorsSavior::Dictionary::LocalDictionary.errors_dictionary
        end

        def error_class
          error_class_name.constantize
        end

        def error_code
          errors_dictionary[error_class_name][__method__].to_i
        end

        def http_status_sym
          errors_dictionary[error_class_name][__method__].to_sym
        end

        def http_status_code
          errors_dictionary[error_class_name][__method__].to_i
        end

        def message
          errors_dictionary[error_class_name][__method__]
        end

        def savior_methods
          %i[error_class error_code http_status_sym http_status_code message]
        end

        def savior_attributes
          savior_methods.each_with_object({}) do |method, base_hash|
            base_hash[method] = public_send(method)
          end
        end
      end
    end
  end
end
