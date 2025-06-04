class ::Clients::Create < Micro::Case
  attributes :params

  def call!
    client = create_client

    Success result: { client: client, message: "Cliente criado com sucesso!" }

  rescue => e
    Failure result: { message: "Não foi possível criar o cliente!", error: e.inspect }
  end

  private

  def create_client
    Client.create!(params)
  end
end
