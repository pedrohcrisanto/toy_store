class ::Statistics::List < Micro::Case
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
    ::Statistics::Repository.call.sales_by_day
  end

  # GET /api/v1/statistics/top_clients
  def top_clients
    Struct.new(
      :top_volume_client,
      :top_average_client,
      :top_frequency_client
    ).new(
      top_volume_client: ::Statistics::Repository.call.top_volume_client,
      top_average_client: ::Statistics::Repository.call.top_average_client,
      top_frequency_client: ::Statistics::Repository.call.top_frequency_client
    )
  end
end
