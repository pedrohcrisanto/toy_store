class ::Statistics::List < Micro::Case
  TOP_VOLUME_CLIENT = "statistics:data:top_volume_client".freeze
  TOP_AVERAGE_CLIENT = "statistics:data:top_average_client".freeze
  TOP_FREQUENCY_CLIENT = "statistics:data:top_frequency_client".freeze
  SALES_BY_DAY = "statistics:data:sales_by_day".freeze

  def call!
    Success result: { sales_by_day: sales_by_day,
                      top_clients: top_clients,
                      message: "Estatísticas geradas com sucesso!" }
  rescue => e
    Failure result: { message: "Não foi possível gerar as estatísticas!", error: e.message }
  end

  private

  def sales_by_day
    Rails.cache.fetch(SALES_BY_DAY, expires_in: 1.hour) do
      sales_data = Sale.group(:sale_date).sum(:value)

      sales_data.map do |date, total_value|
        { date: date.to_s, total_sales: total_value.to_f }
      end.sort_by { |item| item[:date] }
    end
  end

  # GET /api/v1/statistics/top_clients
  def top_clients
    Struct.new(
      :top_volume_client,
      :top_average_client,
      :top_frequency_client
    ).new(
      top_volume_client: top_volume_client,
      top_average_client: top_average_client,
      top_frequency_client: top_frequency_client
    )
  end

  def top_volume_client
    Rails.cache.fetch(TOP_VOLUME_CLIENT, expires_in: 1.hour) do
      Client.joins(:sales)
            .group('clients.id')
            .order('SUM(sales.value) DESC')
            .select('clients.*, SUM(sales.value) as total_volume')
            .first
    end
  end

  def top_average_client
    Rails.cache.fetch(TOP_AVERAGE_CLIENT, expires_in: 1.hour) do
      Client.joins(:sales)
            .group('clients.id')
            .order('AVG(sales.value) DESC')
            .select('clients.*, AVG(sales.value) as average_value')
            .first
    end
  end

  def top_frequency_client
    Rails.cache.fetch(TOP_FREQUENCY_CLIENT, expires_in: 1.hour) do
      Client.joins(:sales)
            .group('clients.id')
            .order(Arel.sql('COUNT(DISTINCT sales.sale_date) DESC'))
            .select('clients.*, COUNT(DISTINCT sales.sale_date) as unique_days')
            .first
    end
  end
end
