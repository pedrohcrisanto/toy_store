module Clients
  class FormatedClients < Micro::Case
    attributes :clients
    def call!
      Success result: { data: formated_attributes }

    rescue => e
      Failure result: { message: "Não foi possivel formatar os clientes", error: e.message }
    end

    private

    def formated_attributes
      clients.map do |client|
        {
          info: {
            nomeCompleto: client.name,
            detalhes: {
              email: client.email,
              nascimento: client.date_of_birth.to_s # Formato YYYY-MM-DD
            }
          },
          estatisticas: {
            vendas: client.sales.map { |sale| { data: sale.sale_date.to_s, valor: sale.value.to_f } }
          }
        }
      end
    end
  end
end