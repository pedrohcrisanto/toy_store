module Clients
  class ListCase < Micro::Case
    attributes :search

    def call!
      Success result: { data: collection, message: "Listado com Sucesso!" }

    rescue => e
      Failure result: { message: "Não foi possivel listar!", error: e.message }
    end

    private

    def clients
      ::Clients::Repository.call!
    end

    def collection
      search.present? ? search : clients
    end

    def search
      ::Clients::Search.call!
    end
  end
end
