module ErrorsSavior
  module Saviors
    class RecordInvalid
      def self.error_class
        ActiveRecord::RecordInvalid.name
      end

      def self.format(exception)
        {
          class: self.error_class,
          errors: format_errors(exception.record.errors.details)
        }
      end

      def self.status
        :unprocessable_entity
      end

      def self.flatten(errors)
        errors.map { |field, f_errors| f_errors.map { |f_error| { field: field }.merge(f_error) } }.flatten
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
