module ErrorsSavior
  module Saviors
    include BaseSavior

    module MySaviors
      class MySavior < StandardError

        def self.error_class_name
          'MySavior'
        end
      end
    end
  end
end
