# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Pour ne pas envoyer des mails lors de la génération de ma DB
::Rails.application.config.action_mailer.perform_deliveries = false


# Version française !
Faker::Config.locale = 'fr'

User.destroy_all
Event.destroy_all
Attendance.destroy_all


puts "Création des Users :"
10.times do
  password = Faker::Internet.password
  # digest = BCrypt::Password.create(password)
  first = Faker::Name.first_name
  last  = Faker::Name.last_name
  email = "#{first}.#{last}@yopmail.com"

  User.create(email: email, password: password, description: Faker::Lorem.sentences(number: 10).join(' '), first_name: first, last_name: last)
  # User.create(email: email, encrypted_password: digest, description: Faker::Lorem.sentences(number: 10).join(' '), first_name: first, last_name: last)
end

  # digest = BCrypt::Password.create(SecureRandom.urlsafe_base64)

puts "Créations des Evenements : "
20.times do
  Event.create(
    start_date: Time.now + rand(1..15).days,
    title: Faker::Lorem.sentences(number: 5).join(' '),
    description: Faker::Lorem.sentences(number: 10).join(' '),
    duration: rand(1..36) * 5,
    price: rand(1..1000),
    location: Faker::Address.city,
    administrator: User.all.sample
  )
end


puts "Créations des Attendances : "
#On crée des participation d'un User (participant) à un événement 
20.times do
  Attendance.create(event: Event.all.sample, stripe_customer_id: "#{SecureRandom.urlsafe_base64}", user: User.all.sample)
end
