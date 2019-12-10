describe ErrorsSavior::Dictionary::LocalDictionary do
  describe '.errors_dictionary' do
    subject(:dictionary) { described_class.errors_dictionary }

    let(:model_saviors) do
      %w[field_validation_error record_invalid record_not_destroyed not_found not_unique]
    end

    let(:controller_saviors) do
      %w[parameter_missing]
    end

    it 'includes model and controller saviors' do
      expect(dictionary.keys).to include(*(model_saviors + controller_saviors))
    end
  end
end
