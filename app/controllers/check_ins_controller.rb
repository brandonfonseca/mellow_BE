# frozen_string_literal: true

require 'json'

# check_ins controller
class CheckInsController < ApplicationController
  before_action :set_check_in, only: %i[show update destroy]

  # GET /check_ins
  def index
    response_body = request.query_parameters
    created_by = response_body["created_by"]
    if !created_by
      @check_ins = CheckIn.all
      json_response(@check_ins)
      return
    end
    @check_ins = CheckIn.where(:created_by => created_by)
    json_response(@check_ins)
  end

  # GET /check_ins/between_dates?created_by=10
  def between_date_range
    response_body = request.query_parameters
    created_by = response_body["created_by"]
    start_date = response_body["start_date"]
    end_date = response_body["end_date"]

    if (!start_date || !end_date) # TODO: check for if the date string is valid
      json_response({ message: "Invalid date(s)" }, :not_found)
      return
    end
    if (created_by)
      @check_ins = CheckIn.where({date_submitted: start_date..end_date, :created_by => created_by})
      json_response(@check_ins)
      return
    end
    @check_ins = CheckIn.where({date_submitted: start_date..end_date})
    json_response(@check_ins)
  end

  # POST /check_ins
  def create
    # note that create! causes the model to raise an exception on error
    # the check_in_params is a callback function that is defined below that ensures that the proper
    # params are passed in before creating the object
    @check_in = CheckIn.create!(check_in_params)
    json_response(@check_in, :created)
  end

  # GET /check_ins/:id
  def show
    json_response(@check_in)
  end

  # PUT /check_ins/:id
  def update
    @check_in.update(check_in_params)
    head :no_content # head just returns an empty content (only headers)
  end

  # DELETE /check_ins/:id
  def destroy
    @check_in.destroy
    head :no_content
  end

  private

  def check_in_params
    # whitelist params
    params.permit(
      :mood,
      :date_submitted,
      :nutrition_rating,
      :cups_of_water,
      :activity_rating,
      :sleep_hours,
      :did_meditate,
      :meditation_rating,
      :created_by
    )
  end

  def set_check_in
    @check_in = CheckIn.find(params[:id])
  end
end
