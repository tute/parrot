# Parrot Gem: Simple commenting solution for Rails 3 apps.

# Installation

1. Add <tt>gem 'parrot'</tt> to your Gemfile
2. Run <tt>rake parrot:install:migrations</tt>
3. Run <tt>rake db:migrate</tt>
4. Run <tt>rails g parrot MODEL_NAME</tt>
5. Add subresources to routes
   <pre>
   resources RESOURCE_NAME do
     resources :parrot_comments, controller: 'parrot/comments', path: 'comments'
   end
   </pre>

# Notes

Given <tt>@comment = Parrot::Comment.find(id)</tt>:

* <tt>rails g parrot MODEL_NAME</tt> (4th step of the installation) adds a
  <tt>parrot_comments</tt> class method in the model. It sets a polymorphic
  relation with <tt>Parrot::Comment</tt>, whose name is <tt>commentable</tt>.
  You can call <tt>@post.comments</tt> to get related comments, or
  <tt>@comment.commentable</tt> to get the related entry of a given comment.
* The default "author" model is <tt>User</tt>. You may change it from
  <tt>config/initializers/parrot.rb</tt>. You can call
  <tt>@comment.author</tt> to get comment's author.
* Parrot views calls <tt>to_s</tt> method on the comment's <tt>author</tt>.
  You may want to alias it, or the "ugly" Ruby object will be shown:
  <tt>alias_method :to_s, :name</tt>
* You may define <tt>after_comment_path</tt> method on commentable model for
  defining where the user should be redirected after commenting (related
  resource by default).

# To-do

* Flash responders working?
* Wiki: how to reopen parrot's subclasses from parent applications?
  (<tt>to_prepare</tt>).
