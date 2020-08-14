# README


* Ruby version : 2.7.1


* Rails version : 5.2.4.2


* Database in : PostGreSQL


Pour l'environnement Héroku, on accepte les clés de test :
git init
git add .
git commit -m 'Mon application Stripe'
heroku create
heroku config:set PUBLISHABLE_KEY=pk_test_TYooMQauvdEDq54NiTphI7jx SECRET_KEY=sk_test_4eC39HqLyjWDarjtT1zdp7dc
git push heroku master
heroku open

Cette ligne contient donc les deux clés utiles :
heroku config:set PUBLISHABLE_KEY=pk_test_TYooMQauvdEDq54NiTphI7jx SECRET_KEY=sk_test_4eC39HqLyjWDarjtT1zdp7dc


## Installation :

# Penser à vérifier la version de ruby : ruby -v : ici 2.7.1
## Si besoin modifier le Gemfile avec votre version (ça devrait passer aussi en 2.5.1)

# Penser à vérifier la version de rails : rails -v : ici 5.2.4.2
## Si besoin faire un : $ gem install rails -v 5.2.4.2

# Penser à faire le bundle install

# Penser à créer la bd :   $ rails db:create
# Penser aux migrations : $ rails db:migrate
# Penser à remplir la bd : $ rails db:seed

# Penser à lancer le serveur : $ rails server

## Allez sur le local host de votre machine au port 3000:
http://localhost:3000/


## Pour l'application sur Heroku :

# elle est directement accessible sur : https://sevenbrite.herokuapp.com/


https://sevenbrite.herokuapp.com/ | https://git.heroku.com/sevenbrite.git

