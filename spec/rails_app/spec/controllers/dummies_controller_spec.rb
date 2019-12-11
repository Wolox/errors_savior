describe DummiesController, type: :controller do
  describe '#create' do
    subject(:make_request) { post :create, params: { name: 'dummy', number: 123 } }

    before do
      make_request
    end

    it 'responds with 200, ok' do
      expect(response).to have_http_status(:ok)
    end
  end
end
