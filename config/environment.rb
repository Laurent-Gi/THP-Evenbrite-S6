# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SENDGRID_LOGIN'],
  :password => ENV['SENDGRID_PWD'],
  :domain => 'nameless-hollows-65115.herokuapp.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}


# Pour ne pas être considéré comme du spam depuis une adresse mail perso :

# Si on veut envoyer directement depuis notre compte gmail :
# ActionMailer::Base.smtp_settings =   {
#     :address            => 'smtp.gmail.com',
#     :port               => 587,
#     :domain             => 'gmail.com', #you can also use google.com
#     :authentication     => :plain,
#     :user_name          => ENV['GMAIL_LOGIN'],
#     :password           => ENV['GMAIL_PWD']
#   }


# Dans le .env : et en variable :
#     :user_name          => ENV['GMAIL_LOGIN'], => Ton adresse mail
#     :password           => ENV['GMAIL_PWD']    => Ton mot de passe !!!!