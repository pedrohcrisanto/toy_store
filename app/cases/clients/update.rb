class ::Clients::Update < Micro::Case
  attributes :id, :params

  def call!
    Success result: { data: client, message: "Cliente atualizado com sucesso!" }
  rescue => e
    Failure result: { message: "Não foi possível atualizar o cliente!", error: e.inspect }
  end

  private

  def update_client
    client.update!(params)
  end

  def client
    @client ||= Client.find(id)
  end
end
