module ErrorsSavior
  module Saviors
    class ParameterMissing
      include BaseSavior

      def self.error_class_name
        'ActionController::ParameterMissing'
      end

      def self.errors(error)
        { error.param => error.message }
      end
    end
  end
end
