# app/controllers/api/v1/clients_controller.rb
class Api::V1::ClientsController < ApplicationController
  before_action :authenticate_user!

  # GET /api/v1/clients
  def index
    result = Clients::List.call(search: search)

    if result.success?
      render json: { data: result.data,
                     message: result.message,
                     meta: pagination }, status: :ok
    else
      render json: { message: result.message, error: result.error }
    end
  end

  # GET /api/v1/clients/:id
  def show
    result = Clients::Show.call(id: params[:id])

    if result.success?
      render json: { data: result.data,
                     message: result.message,
                     meta: pagination }, status: :ok
    else
      render json: { message: result.message, error: result.error }
    end
  end

  # POST /api/v1/clients
  def create
    result = Clients::Create.call(params: client_params)

    if result.success?
      render json: { data: result.data,
                     message: result.message,
                     meta: pagination }, status: :ok
    else
      render json: { message: result.message, error: result.error }
    end
  end

  # PATCH/PUT /api/v1/clients/:id
  def update
    result = Clients::Update.call(params: client_params,
                                  id: params[:id])

    if result.success?
      render json: { data: result.data,
                     message: result.message,
                     meta: pagination }, status: :ok
    else
      render json: { message: result.message, error: result.error }
    end
  end

  # DELETE /api/v1/clients/:id
  def destroy
    result = Clients::Destroy.call(id: params[:id])

    if result.success?
      render json: { data: result.data,
                     message: result.message,
                     meta: pagination }, status: :ok
    else
      render json: { message: result.message, error: result.error }
    end
  end

  private

  def client_params
    params.require(:client).permit(:name, :email, :date_of_birth, :search)
  end

  def pagination
  end
end
