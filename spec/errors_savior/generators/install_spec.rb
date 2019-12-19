require 'generator_spec'
require 'generators/errors_savior/install'

describe ErrorsSavior::Generators::Install, type: :generator do
  context 'generating the initializer ' do
    destination File.expand_path('../../../tmp', __FILE__)

    before(:all) do
      prepare_destination
      run_generator
    end

    # rubocop:disable Style/BlockDelimiters
    it 'generates the correct structure for initializer' do
      expect(destination_root).to(have_structure {
        no_file 'errors_savior.rb'
        directory 'config' do
          no_file 'errors_savior.rb'
          directory 'initializers' do
            file 'errors_savior.rb' do
              contains 'ErrorsSavior.configure do'
            end
          end
        end
      })
    end
    # rubocop:enable Style/BlockDelimiters
  end
end
