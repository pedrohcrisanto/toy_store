# app/controllers/api/v1/sales_controller.rb
class Api::V1::SalesController < Api::V1::BaseController
  before_action :authenticate_user!

# POST /api/v1/sales
  def create
    result = ::Sales::Create.call(params: sale_params)

    if result.success?
      render json: { data: blueprint(result.data[:sales]),
                     message: result.data[:message]}, status: :created
    else
      render json: { message: result.data[:message],
                     error: result.data[:error] }, status: :unprocessable_entity
    end
  end

  private

  def sale_params
    params.require(:sale).permit(:client_id, :value, :sale_date)
  end

  def blueprint(collection)
    ::SalesBlueprint.render_as_json(collection)
  end
end
