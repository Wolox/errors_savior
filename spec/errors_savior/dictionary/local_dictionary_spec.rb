describe ErrorsSavior::Dictionary::LocalDictionary do
  describe '.errors_dictionary' do
    subject(:dictionary) { described_class.errors_dictionary }

    let(:savior_errors) do
      %w[ActiveModel::ValidationError ActiveRecord::RecordInvalid
         ActiveRecord::RecordNotDestroyed ActiveRecord::RecordNotFound
         ActiveRecord::RecordNotUnique ActionController::ParameterMissing]
    end

    it 'includes model and controller saviors' do
      expect(dictionary.keys).to include(*savior_errors)
    end

    it 'includes the required attributes' do
      required_attributes = described_class.required_attributes
      expect(dictionary).to be_all do |_error_sym, attributes|
        required_attributes == attributes.keys.map(&:to_sym)
      end
    end
  end
end
