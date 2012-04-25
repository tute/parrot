module Parrot
  class Comment < ActiveRecord::Base
    belongs_to :commentable, :polymorphic => true
    belongs_to :author, :class_name => :user # TODO: user should be configurable

    validates_presence_of :commentable, :body, :user_id

    def self.following(other_comment)
      where("created_at > '#{other_comment.created_at}'")
    end
  end
end
