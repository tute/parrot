module Parrot
  class Comment < ActiveRecord::Base
    self.table_name = :parrot_comments # FIXME: Not needed if I can isolate the gem

    belongs_to :commentable, :polymorphic => true
    belongs_to :author, :class_name => Parrot.author_class

    attr_accessible :commentable, :body

    validates_presence_of :commentable, :body, :author_id

    def self.following(other_comment)
      where("created_at > '#{other_comment.created_at}'")
    end

    def author
      Parrot.author_class.find(author_id)
    end
  end
end
