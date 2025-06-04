class ::Sales::Create < ::Micro::Case
  attributes :params
  def call!
    sales = create_sale

    Success result: { sales: sales, message: "Compra criado com sucesso!" }

  rescue => e
    Failure result: { message: "Não foi possível criar a compra!", error: e.inspect }
  end

  private

  def create_sale
    Sale.create!(params)
  end
end
