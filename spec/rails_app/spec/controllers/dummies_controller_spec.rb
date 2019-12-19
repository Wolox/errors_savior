describe DummiesController, type: :controller do
  describe '#create' do
    subject(:make_request) { post :create, params: create_params }

    context 'with correct values' do
      let(:create_params) do
        { name: 'dummy', number: 123 }
      end

      before do
        make_request
      end

      it 'responds with 200, ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when creates not unique record' do
      let(:repeated_data) do
        { name: 'repeated', number: 456 }
      end
      let(:create_params) { repeated_data }
      let(:dummy_instance) { Dummy.create(repeated_data) }
      let(:required_error_body_keys) { %w[error_code message timestamp metadata] }

      before do
        dummy_instance
        make_request
      end

      it 'responds with unprocessable_entity status code' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'rescuted by savior gem and render properly output' do
        expect(response_body.keys).to eq(required_error_body_keys)
      end
    end

    context 'without required param' do
      let(:create_params) do
        { name: 'dummy' }
      end

      before do
        make_request
      end

      it 'responds with 400, bad_request' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'rescuted by parameter_missing savior' do
        expect(response_body['errors']['number']).to \
          eq('param is missing or the value is empty: number')
      end
    end
  end
end
