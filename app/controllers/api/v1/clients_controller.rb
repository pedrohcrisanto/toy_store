# app/controllers/api/v1/clients_controller.rb
class Api::V1::ClientsController < Api::V1::BaseController
  # before_action :authenticate_user!

  # GET /api/v1/clients
  def index
    result = Clients::List.call(q: params[:q])
    @pagy, @clients = pagy(result.data[:clients])

    if result.success?
      render json: { clients: blueprint(@clients),
                     message: result.data[:message],
                     meta: @pagy }, status: :ok
    else
      render json: { message: result.data[:message], error: result.data[:error] }
    end
  end

  # GET /api/v1/clients/:id
  def show
    result = Clients::Show.call(id: params[:id])

    if result.success?
      render json: { data: blueprint(result.data[:client]),
                     message: result.data[:message]}, status: :ok
    else
      render json: { message: result.data[:message], error: result.data[:error] }, status: :not_found
    end
  end

  # POST /api/v1/clients
  def create
    result = Clients::Create.call(params: client_params)

    if result.success?
      render json: { data: blueprint(result.data[:client]),
                     message: result.data[:message]}, status: :created
    else
      render json: { message: result.data[:message], error: result.data[:error] }
    end
  end

  # PATCH/PUT /api/v1/clients/:id
  def update
    result = Clients::Update.call(params: client_params,
                                  id: params[:id])

    if result.success?
      render json: { data: blueprint(result.data[:client]),
                     message: result.data[:message]}, status: :ok
    else
      render json: { message: result.data[:message], error: result.data[:error] }
    end
  end

  # DELETE /api/v1/clients/:id
  def destroy
    result = Clients::Destroy.call(id: params[:id])

    if result.success?
      render json: { data: blueprint(result.data[:client]),
                     message: result.data[:message]}, status: :ok
    else
      render json: { message: result.data[:message], error: result.data[:error] }, status: :not_found
    end
  end

  private

  def client_params
    params.require(:client).permit(:name, :email, :date_of_birth)
  end

  def blueprint(collection)
    ClientsBlueprint.render_as_json(collection)
  end
end
