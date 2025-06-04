class ::Statistics::List < Micro::Case
  CACHE_KEY = "statistics:data"

  def call!
    Success result: { data: data, message: "Estatísticas geradas com sucesso!" }
  rescue => e
    Failure result: { message: "Não foi possível gerar as estatísticas!", error: e.inspect }
  end

  private

  def data
    Rails.cache.fetch(CACHE_KEY, expires_in: 1.hour) do
      {
        sales_by_day: sales_by_day,
        top_clients: top_clients
      }
    end
  end

  def sales_by_day
    sales_data = Sale.group(:sale_date).sum(:value)

    sales_data.map do |date, total_value|
      { date: date.to_s, total_sales: total_value.to_f }
    end.sort_by { |item| item[:date] }
  end

  # GET /api/v1/statistics/top_clients
  def top_clients
    {
      top_volume_client: top_volume_client,
      top_average_client: top_average_client,
      top_frequency_client: top_frequency_client
    }
  end

  def top_volume_client
    clients.group('clients.id')
           .order('SUM(sales.value) DESC')
           .select('clients.*, SUM(sales.value) as total_volume')
           .first
  end

  def top_average_client
    clients.order('AVG(sales.value) DESC')
           .select('clients.*, AVG(sales.value) as average_value')
           .first

  end

  def top_frequency_client
    clients.order('COUNT(DISTINCT sales.sale_date) DESC')
           .select('clients.*, COUNT(DISTINCT sales.sale_date) as unique_days')
           .first
  end

  def clients
    @clients ||= Client.includes(:sales).joins(:sales)
  end
end