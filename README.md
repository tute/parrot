# Parrot Gem: Simple commenting solution for Rails 3 apps.

# Installation

1. Add <tt>gem 'parrot'</tt> to your Gemfile
2. Run <tt>rails g parrot:install</tt>
3. Run <tt>rails g parrot MODEL_NAME</tt>
4. Run <tt>rake db:migrate</tt>
5. Add subresources to routes
     resources RESOURCE_NAME do
       resources :comments, controller: 'parrot/comments'
     end

# To-do list:

* <tt>belongs_to :author</tt> should have configurable class_name (now User).
