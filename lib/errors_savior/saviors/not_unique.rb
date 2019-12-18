module ErrorsSavior
  module Saviors
    class NotUnique < BaseSavior
      def self.error_class_name
        'ActiveRecord::RecordNotUnique'
      end
    end
  end
end
