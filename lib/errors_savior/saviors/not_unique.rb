module ErrorsSavior
  module Saviors
    class NotUnique < BaseSavior
      def self.error_sym
        :not_unique
      end
    end
  end
end
