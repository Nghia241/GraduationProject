# db/seeds.rb
# Seed data for roles
roles = [
  { role_name: 'super admin', description: 'Has full access to the system' },
  { role_name: 'admin', description: 'Can manage and oversee general operations' },
  { role_name: 'user', description: 'Can access limited features' }
]

# Insert roles into the database
roles.each do |role|
  SystemRole.find_or_create_by(role_name: role[:role_name]) do |r|
    r.description = role[:description]
    r.created_at = Time.now
    r.updated_at = Time.now
  end
end

puts 'Roles have been successfully seeded!'
