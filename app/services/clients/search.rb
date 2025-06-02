module Clients
  class Search < Micro::Case
    attributes :query

    def call!
      Success result: { data: search }

    rescue => e
      Failure result: { message: "Não foi possivel buscar!", error: e.message }
    end

    private

    def by_name
      @clients&.where("name LIKE ?", "%#{q}%")
    end

    def search
      by_name if query.present?
    end

    def clients
      @clients  = ::Clients::Repository.call!
    end
  end
end
