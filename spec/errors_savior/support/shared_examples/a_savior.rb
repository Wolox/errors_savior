shared_examples 'a savior' do
  let(:dictionary) do
    ErrorsSavior::Dictionary::LocalDictionary.errors_dictionary
  end

  let(:dictinary_data) do
    dictionary[error_class_name][attribute]
  end

  describe '#error_code' do
    let(:attribute) { :error_code }

    it { expect(described_class.error_code).to eq(dictinary_data) }
  end

  describe '#error_class' do
    let(:attribute) { :error_class }

    it { expect(described_class.error_class).to eq(error_class_name.constantize) }
  end

  describe '#http_status_sym' do
    let(:attribute) { :http_status_sym }

    it { expect(described_class.http_status_sym).to eq(dictinary_data.to_sym) }
  end

  describe '#http_status_code' do
    let(:attribute) { :http_status_code }

    it { expect(described_class.http_status_code).to eq(dictinary_data) }
  end

  describe '#message' do
    let(:attribute) { :message }

    it { expect(described_class.message).to eq(dictinary_data) }
  end
end
