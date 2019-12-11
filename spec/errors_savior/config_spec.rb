require 'spec_helper'
require 'helpers/errors_savior/config_helper'

describe ErrorsSavior::Config, type: :controller do
  context 'with default config' do
    described_class::DEFAULT_CONFIG.each do |attribute, value|
      before do
        ErrorsSavior::ConfigHelper.reset!
      end

      it 'responds to the attribute' do
        expect(described_class).to respond_to(attribute)
      end

      it 'has a default' do
        expect(described_class.send(attribute)).to be(value)
      end
    end
  end

  described_class::DEFAULT_CONFIG.each do |attribute, _value|
    context "when changing #{attribute}" do
      let(:random_attribute) { rand(300) }

      before do
        ErrorsSavior::ConfigHelper.reset!

        ErrorsSavior.configure do |config|
          config.send("#{attribute}=", random_attribute)
        end
      end

      it 'changes to the applied value' do
        expect(described_class.send(attribute)).to be(random_attribute)
      end
    end
  end
end
