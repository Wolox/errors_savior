module ErrorsSavior
  module Generators
    class Install < Rails::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)
      desc 'Creates ErrorsSavior initializer for your application'

      def copy_initializer
        template 'errors_savior.rb', 'config/initializers/errors_savior.rb'
      end
    end
  end
end
