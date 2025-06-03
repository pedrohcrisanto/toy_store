class ::Clients::Show < Micro::Case
  attributes :id

  def call!
    Success result: { client: find_client, message: "Cliente encontrado com sucesso!" }
  rescue => e
    Failure result: { message: "Não foi possível encontrar o cliente!", error: e.inspect }
  end

  private

  def find_client
    Client.find(id)
  end
end
