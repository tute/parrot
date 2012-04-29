class Post < ActiveRecord::Base
  parrot_comments

  attr_accessible :body, :title
end
