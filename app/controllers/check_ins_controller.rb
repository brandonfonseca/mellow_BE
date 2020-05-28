# frozen_string_literal: true

# check_ins controller
class CheckInsController < ApplicationController
  before_action :set_check_in, only: %i[show update destroy]

  # GET /check_ins
  def index
    @check_ins = CheckIn.all
    json_response(@check_ins)
  end

  # POST /check_ins
  def create
    # note that create! causes the model to raise an exception on error
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
