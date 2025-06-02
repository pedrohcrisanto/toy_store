# app/controllers/users.rb/sessions_controller.rb

class Users::SessionsController < Devise::SessionsController
  respond_to :json # Responda em JSON

  private

  def respond_with(resource, _opts = {})
    render json: {
      status: { code: 200, message: 'Logado com sucesso.' },
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes] # Use um serializador para retornar os dados do usuário
    }, status: :ok
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],
                             Rails.application.credentials.secret_key_base).first
    current_user = User.find(jwt_payload['sub'])

    if current_user
      render json: {
        status: { code: 200, message: 'Deslogado com sucesso.' }
      }, status: :ok
    else
      render json: {
        status: { code: 401, message: 'Não foi possível deslogar.' }
      }, status: :unauthorized
    end
  end
end
