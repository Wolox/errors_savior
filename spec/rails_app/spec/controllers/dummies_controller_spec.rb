require 'spec_helper'

describe DummiesController, type: :controller do
  describe 'POST #create' do
    subject(:make_request) { post :create }

    before do
      make_request
    end

    it 'responds with 200, ok' do
      expect(response).to have_http_status(:ok)
    end
  end
end
