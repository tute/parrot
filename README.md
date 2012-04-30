# Parrot Gem: Simple commenting solution for Rails 3 apps.

# Installation

1. Add <tt>gem 'parrot'</tt> to your Gemfile
2. Run <tt>rake parrot:install:migrations</tt>
3. Run <tt>rake db:migrate</tt>
4. Run <tt>rails g parrot MODEL_NAME</tt>
5. Add subresources to routes

     resources RESOURCE_NAME do
       resources :parrot_comments, controller: 'parrot/comments', path: 'comments'
     end

# Notes

* By default it calls to_s on commenter name. You may want to alias it to name
  for example, so it doesn't show the Ruby "ugly" object.
