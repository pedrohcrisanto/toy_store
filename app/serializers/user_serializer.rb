# app/serializers/user_serializer.rb

class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :email, :created_at, :updated_at # Adicione os atributos que deseja expor
end
