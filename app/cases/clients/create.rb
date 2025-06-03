class ::Clients::Create < Micro::Case
  attributes :params

  def call!
    client = create_client

    Success result: { data: client, message: "Cliente criado com sucesso!" }

  rescue => e
    Failure result: { message: "Não foi possível criar o cliente!", error: e.message }
  end

  private

  def create_client
    Client.create!(params)
  rescue => e
    raise e
  end
end
