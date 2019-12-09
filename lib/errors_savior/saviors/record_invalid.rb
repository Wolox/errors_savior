module ErrorsSavior
  module Saviors
    class RecordInvalid
      def self.error_class
        ActiveRecord::RecordInvalid.name
      end

      def self.format(exception)
        {
          class: error_class,
          errors: format_errors(exception.record.errors.details)
        }
      end

      def self.status
        :unprocessable_entity
      end

      def self.flatten(errors)
        errors.map do |field, f_errors|
          f_errors.map do |f_error|
            { field: field }.merge(f_error)
          end
        end.flatten
      end

      def self.format_errors(errors)
        flatten(errors).map do |error|
          { type: error[:error], status_code: 101, field: error[:field] }
        end
      end

      private_class_method :flatten
      private_class_method :format_errors
    end
  end
end
