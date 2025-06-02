# app/controllers/users.rb/registrations_controller.rb

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json # Responda em JSON

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        status: { code: 200, message: 'Registrado com sucesso.' },
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }, status: :ok
    else
      render json: {
        status: { message: "Usuário não pôde ser criado com sucesso. #{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end
end
