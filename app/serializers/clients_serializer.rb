class ClientsSerializer
  include JSONAPI::Serializer

  set_key_transform :camel_lower

  attributes :id, :name, :email, :date_of_birth
end
