class ::Clients::Destroy < Micro::Case
  attributes :id

  def call!
    Success result: { client: destroy_client, message: "Cliente removido com sucesso!" }

  rescue => e
    Failure result: { message: "Não foi possível remover o cliente!", error: e.inspect }
  end

  private

  def destroy_client
    find_client&.destroy!

    find_client
  rescue => e
    raise e
  end

  def find_client
    @find_client ||= Client.find(id)
  end
end
