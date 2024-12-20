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

languages = [
  { locale: 'en', created_at: Time.now, updated_at: Time.now },
  { locale: 'vi', created_at: Time.now, updated_at: Time.now },
]

languages.each do |language|
  Language.find_or_create_by(locale: language[:locale]) do |l|
    l.created_at = language[:created_at]
    l.updated_at = language[:updated_at]
  end
end

puts "Seeded Languages successfully!"

# Seed data for users
users = [
  { name: 'Super Admin', email: 'superadmin@example.com', password: 'password', system_role_id: 1, language_id: 1 },
  { name: 'Admin', email: 'admin@example.com', password: 'password', system_role_id: 2, language_id: 1 },
  { name: 'User', email: 'user@example.com', password: 'password', system_role_id: 3, language_id: 2 }
]

users.each do |user|
  User.find_or_create_by!(email: user[:email]) do |u|
    u.name = user[:name]
    u.system_role_id = user[:system_role_id]
    u.language_id = user[:language_id]
    u.password = user[:password]
    u.created_at = Time.now
    u.updated_at = Time.now
  end
end

puts "Seeded Users successfully!"
