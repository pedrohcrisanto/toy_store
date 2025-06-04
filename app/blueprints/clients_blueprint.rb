class ClientsBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :email, :date_of_birth

  association :sales, blueprint: ::SalesBlueprint
end