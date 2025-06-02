# app/controllers/api/v1/sales_controller.rb
class Api::V1::SalesController < ApplicationController
  # POST /api/v1/sales
  def create
    sale = Sale.new(sale_params)

    if sale.save
      render json: sale, status: :created
    else
      render json: { errors: sale.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def sale_params
    params.require(:sale).permit(:client_id, :value, :sale_date)
  end
end
