require 'spec_helper'

describe DummiesController, type: :controller do
  describe 'POST #create' do
    subject(:http_request) { post :create }

    before do
      http_request
    end

    it 'responds with 200, ok' do
      byebug
      expect(response).to have_http_status(:ok)
    end
  end
end
