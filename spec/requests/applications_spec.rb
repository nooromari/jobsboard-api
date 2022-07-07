# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Applications', type: :request do
  let!(:job) { create(:job) }
  let!(:applications) { create_list(:application, 20, job_id: job.id, user_id: user.id) }
  let(:job_id) { job.id }
  let(:id) { applications.first.id }

  let(:user) { create(:user) }
  let(:admin) { create(:user, is_admin: true) }

  let(:headers) { valid_headers }
  let(:headers_admin) { valid_admin_headers }


  describe 'GET /jobs/:job_id/applications' do
    before { get "/jobs/#{job_id}/applications", params: { user_id: user.id }, headers: headers_admin }
    it 'returns applications' do
      expect(json).not_to be_empty
      expect(json.size).to eq(20)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /jobs/:job_id/applications/:id' do
    before { get "/jobs/#{job_id}/applications/#{id}", params: { user_id: user.id }, headers: headers_admin }
    context 'when the record exists' do
      it 'returns the application' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(id)
        expect(json['job_id']).to eq(job_id)
        expect(json['user_id']).to eq(user.id)
        expect(json['seen']).to eq(true)
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
    context 'when the record does not exist' do
      let(:id) { 100 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Application/)
      end
    end
  end

  describe 'POST /jobs/:job_id/applications' do
    let(:valid_attributes) do
      {
        user_id: user.id,
        job_id: job.id,
        seen: false
      }.to_json
    end
    context 'when the request is valid' do
      before { post "/jobs/#{job_id}/applications", params: valid_attributes, headers: }
      it 'creates a application' do
        expect(json['user_id']).to eq(user.id)
        expect(json['job_id']).to eq(job.id)
        expect(json['seen']).to eq(false)
      end
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
    context 'when the request is invalid' do
      before { post "/jobs/#{job_id}/applications", params: {}, headers: {} }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
      it 'returns a validation failure message' do
        expect(response.body).to match(/Missing token/)
      end
    end
  end
end
