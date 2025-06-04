# app/controllers/api/v1/statistics_controller.rb
class Api::V1::StatisticsController < Api::V1::BaseController
  # GET /api/v1/statistics/sales_by_day
  before_action :authenticate_user!

  def index
    result = ::Statistics::List.call

    if result.success?
      render json: { data: blueprint(result.data), message: result.message }, status: :ok
    else
      render json: { message: result.message, error: result.error }, status: :unprocessable_entity
    end
  end

  def blueprint(data)
    ::StatisticsBlueprint.render_as_json(data)
  end
end
