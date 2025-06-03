module Clients
  class List < Micro::Case
    attributes :q

    def call!
      Success result: { clients: list_clients, message: "Listado com Sucesso!" }
    rescue => e
      Failure result: { message: "Não foi possivel listar!", error: e.inspect }
    end

    private

    def clients
      @clients ||= Client.all
    end

    def list_clients
      return clients if q.blank?

      search
    end

    def search
      clients&.where("name LIKE ? OR email LIKE ?", "%#{q}%", "%#{q}%")
    end
  end
end
