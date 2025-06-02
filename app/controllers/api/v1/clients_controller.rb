# app/controllers/api/v1/clients_controller.rb
class Api::V1::ClientsController < ApplicationController
  before_action :set_client, only: [ :show, :update, :destroy ]

  # GET /api/v1/clients
  def index
    result = Clients::ListCase.call(search: search)

    if result.success?
      render json: { data: result.data,
                     message: result.message,
                     meta: pagination }, status: :ok
    else
      render json: { message: result.message }
    end
  end

  # GET /api/v1/clients/:id
  def show
    render json: @client, status: :ok
  end

  # POST /api/v1/clients
  def create
    client = Client.new(client_params)

    if client.save
      render json: client, status: :created
    else
      render json: { errors: client.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/clients/:id
  def update
    if @client.update(client_params)
      render json: @client, status: :ok
    else
      render json: { errors: @client.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/clients/:id
  def destroy
    @client.destroy
    head :no_content
  end

  private

  def set_client
    @client = Client.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Cliente não encontrado" }, status: :not_found
  end

  def client_params
    params.require(:client).permit(:name, :email, :date_of_birth, :search)
  end

  def pagination

  end
end
