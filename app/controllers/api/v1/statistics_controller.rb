# app/controllers/api/v1/statistics_controller.rb
class Api::V1::StatisticsController < Api::V1::BaseController
# GET /api/v1/statistics/sales_by_day
  def sales_by_day
    sales_data = Sale.group(:sale_date).sum(:value)
    formatted_data = sales_data.map do |date, total_value|
      { date: date.to_s, total_sales: total_value.to_f }
    end.sort_by { |item| item[:date] } # Ordena por data

    render json: formatted_data, status: :ok
  end

  # GET /api/v1/statistics/top_clients
  def top_clients
    # Cliente com maior volume de vendas
    top_volume_client = Client.joins(:sales)
                              .group('clients.id')
                              .order('SUM(sales.value) DESC')
                              .select('clients.*, SUM(sales.value) as total_volume')
                              .first

    # Cliente com maior média de valor por venda
    top_average_client = Client.joins(:sales)
                               .group('clients.id')
                               .order('AVG(sales.value) DESC')
                               .select('clients.*, AVG(sales.value) as average_value')
                               .first

    # Cliente com maior número de dias únicos com vendas registradas (frequência de compra)
    top_frequency_client = Client.joins(:sales)
                                 .group('clients.id')
                                 .order('COUNT(DISTINCT sales.sale_date) DESC')
                                 .select('clients.*, COUNT(DISTINCT sales.sale_date) as unique_days')
                                 .first

    render json: {
      top_volume_client: top_volume_client ? {
        id: top_volume_client.id,
        name: top_volume_client.name,
        email: top_volume_client.email,
        total_volume: top_volume_client.total_volume.to_f
      } : nil,
      top_average_client: top_average_client ? {
        id: top_average_client.id,
        name: top_average_client.name,
        email: top_average_client.email,
        average_value: top_average_client.average_value.to_f
      } : nil,
      top_frequency_client: top_frequency_client ? {
        id: top_frequency_client.id,
        name: top_frequency_client.name,
        email: top_frequency_client.email,
        unique_days: top_frequency_client.unique_days.to_i
      } : nil
    }, status: :ok
  end
end
