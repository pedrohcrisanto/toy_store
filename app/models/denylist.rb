# app/models/denylist.rb

class Denylist < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Denylist

  self.table_name = 'denylists' # Garante o nome correto da tabela
end