# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Jobs', type: :request do
  let!(:jobs) { create_list(:job, 10) }
  let(:job_id) { jobs.first.id }

  let(:user) { create(:user) }
  let(:admin) { create(:user, is_admin: true) }

  let(:headers) { valid_headers }
  let(:headers_admin) { valid_admin_headers }

  let!(:jobs) { create_list(:job, 10) }
  let(:job_id) { jobs.first.id }

  describe 'GET /jobs' do
    before { get '/jobs', params: {}, headers: }

    it 'returns jobs' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /jobs/:id' do
    before { get "/jobs/#{job_id}", params: {}, headers: }

    context 'when the record exists' do
      it 'returns the job' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(job_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:job_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Job/)
      end
    end
  end

  describe 'POST /jobs' do
    let(:valid_attributes) do
      { title: 'Software Developer', description: 'Good Knowledge in frontend and backend development' }.to_json
    end

    context 'when the request is valid' do
      before { post '/jobs', params: valid_attributes, headers: headers_admin }

      it 'creates a job' do
        expect(json['title']).to eq('Software Developer')
        expect(json['description']).to eq('Good Knowledge in frontend and backend development')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { title: nil, description: nil }.to_json }
      before { post '/jobs', params: invalid_attributes, headers: headers_admin }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Title can't be blank, Description can't be blank/)
      end
    end
  end

  describe 'PUT /jobs/:id' do
    let(:valid_attributes) { { title: 'Programmer' }.to_json }

    context 'when the record exists' do
      before { put "/jobs/#{job_id}", params: valid_attributes, headers: headers_admin }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /jobs/:id' do
    before { delete "/jobs/#{job_id}", params: {}, headers: headers_admin }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
