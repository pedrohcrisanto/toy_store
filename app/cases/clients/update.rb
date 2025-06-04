class ::Clients::Update < Micro::Case
  attributes :id, :params

  def call!
    Success result: { client: update_client, message: "Cliente atualizado com sucesso!" }
  rescue => e
    Failure result: { message: "Não foi possível atualizar o cliente!", error: e.inspect }
  end

  private

  def update_client
    client.update!(params)

    client
  end

  def client
    Client.find(id)
  end
end
