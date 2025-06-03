module Clients
  class Search < Micro::Case
    attributes :query, :collection

    def call!
      Success result: { data: search }
    rescue => e
      Failure result: { message: "Não foi possivel buscar!", error: e.inspect }
    end

    private

    def search
      collection&.where("name LIKE ? OR email LIKE ?", "%#{query}%", "%#{query}%")
    end
  end
end
