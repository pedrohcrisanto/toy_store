puts 'Criando usuário de teste...'
user = User.find_or_create_by!(email: 'test@example.com') do |u|
  u.password = 'password123'
  u.password_confirmation = 'password123'
end
puts "Usuário criado: #{user.email}"

# Cria clientes de exemplo
puts 'Criando clientes de exemplo...'
client1 = Client.find_or_create_by!(email: 'ana.b@example.com') do |c|
  c.name = 'Ana Beatriz'
  c.date_of_birth = '1992-05-01'
end

client2 = Client.find_or_create_by!(email: 'cadu@example.com') do |c|
  c.name = 'Carlos Eduardo'
  c.date_of_birth = '1987-08-15'
end

client3 = Client.find_or_create_by!(email: 'maria.s@example.com') do |c|
  c.name = 'Maria Silva'
  c.date_of_birth = '1990-11-20'
end

client4 = Client.find_or_create_by!(email: 'joao.p@example.com') do |c|
  c.name = 'João Pedro'
  c.date_of_birth = '1985-03-10'
end

puts 'Criando vendas de exemplo...'
# Vendas para Ana Beatriz
Sale.find_or_create_by!(client: client1, sale_date: '2024-01-01', value: 150.00)
Sale.find_or_create_by!(client: client1, sale_date: '2024-01-02', value: 50.00)
Sale.find_or_create_by!(client: client1, sale_date: '2024-01-05', value: 200.00)

# Vendas para Carlos Eduardo (sem vendas inicialmente, para testar cenário)
# Sale.create(client: client2, sale_date: '2024-02-10', value: 100.00)

# Vendas para Maria Silva (maior volume e média)
Sale.find_or_create_by!(client: client3, sale_date: '2024-01-01', value: 300.00)
Sale.find_or_create_by!(client: client3, sale_date: '2024-01-02', value: 400.00)
Sale.find_or_create_by!(client: client3, sale_date: '2024-01-03', value: 350.00)

# Vendas para João Pedro (maior frequência)
Sale.find_or_create_by!(client: client4, sale_date: '2024-01-01', value: 10.00)
Sale.find_or_create_by!(client: client4, sale_date: '2024-01-03', value: 20.00)
Sale.find_or_create_by!(client: client4, sale_date: '2024-01-05', value: 15.00)
Sale.find_or_create_by!(client: client4, sale_date: '2024-01-07', value: 25.00)
Sale.find_or_create_by!(client: client4, sale_date: '2024-01-09', value: 30.00)

puts 'Dados de exemplo criados com sucesso!'
