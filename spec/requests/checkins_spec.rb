# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Check_ins API', type: :request do
  # initialize test data
  let!(:check_ins) { create_list(:check_in, 10) }
  let(:check_in_id) { check_ins.first.id }
  let(:mock_date) { check_ins.first.date_submitted }
  let(:mock_created_by) {check_ins.first.created_by}

  # Test suite for GET /check_ins
  describe 'GET /check_ins' do
    # make HTTP get request before each example
    before { get '/check_ins' }

    it 'returns check_ins' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /check_ins?created_by=[number]' do
    # make HTTP get request before each example
    before { get '/check_ins', params: {created_by: mock_created_by} }

    it 'returns the check_ins with the passed created_by id' do
      expect(json).not_to be_empty
      expected_size = check_ins.delete_if {|check_in| check_in["created_by"] != mock_created_by}.length
      expect(json.length). to eq(expected_size)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /check_ins/:id
  describe 'GET /check_ins/:id' do
    before { get "/check_ins/#{check_in_id}" }

    context 'when the record exists' do
      it 'returns the check_in' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(check_in_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:check_in_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find CheckIn/)
      end
    end
  end

  # Test suite for GET /check_ins/between_dates
  describe 'GET /check_ins/between_dates' do    
    
    context 'when the date range is valid and exists' do
      before { get "/check_ins/between_dates", params: {start_date: mock_date, end_date: mock_date, created_by:  mock_created_by} }
      
      it 'returns the check_ins within the date range' do
        expect(json).not_to be_empty
        expected_size = check_ins.delete_if {|check_in| (check_in["date_submitted"] != mock_date) || (check_in["created_by"]!= mock_created_by)}.length
        expect(json.length). to eq(expected_size)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
    
    context 'when the date range is valid but does not exist' do
      before { get "/check_ins/between_dates", params: {start_date: '2015-01-01', end_date: '2015-01-01' } }
      
      it 'returns the check_ins within the date range' do
        expect(json).to be_empty
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the date range is invalid' do
      before { get "/check_ins/between_dates", params: {start_date: '2015-01-01'} }
      
      it 'returns error message' do
        expect(json)
          .to include("message" => "Invalid date(s)")
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Test suite for POST /check_ins
  describe 'POST /check_ins' do
    mock_date = '2020-05-01'
    # valid payload
    let(:valid_attributes) do
      { date_submitted: mock_date,
        mood: 1,
        cups_of_water: 2,
        activity_rating: 3,
        sleep_hours: 4,
        nutrition_rating: 5,
        did_meditate: true,
        meditation_rating: 5 }
    end

    context 'when the request is valid' do
      before { post '/check_ins', params: valid_attributes }

      it 'creates a check_in' do
        expect(json['date_submitted']).to eq(mock_date)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before do
        post '/check_ins', params: {
          mood: 1,
          cups_of_water: 2,
          activity_rating: 3,
          sleep_hours: 4,
          nutrition_rating: 5,
          did_meditate: true,
          meditation_rating: 5
        }
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Date submitted can't be blank/)
      end
    end
  end

  # Test suite for PUT /check_ins/:id
  describe 'PUT /check_ins/:id' do
    let(:valid_attributes) { { meditation_rating: 3 } }

    context 'when the record exists' do
      before { put "/check_ins/#{check_in_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /check_ins/:id
  describe 'DELETE /check_ins/:id' do
    before { delete "/check_ins/#{check_in_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
