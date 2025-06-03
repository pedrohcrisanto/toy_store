module Clients
  class ListCase < Micro::Case
    attributes :q

    def call!
      Success result: { data: list_clients, message: "Listado com Sucesso!" }
    rescue => e
      Failure result: { message: "Não foi possivel listar!", error: e.inspect }
    end

    private

    def collection
      ::Clients::Repository.call
    end

    def list_clients
      return collection if q.blank?

      search
    end

    def search
      ::Clients::Search.call(query: q, collection: collection).result.data
    end
  end
end
