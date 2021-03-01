module ErrorsSavior
  module Saviors
    class NotUnique
      include BaseSavior

      def self.error_class_name
        'ActiveRecord::RecordNotUnique'
      end
    end
  end
end
