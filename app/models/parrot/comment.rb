module Parrot
  class Comment < ActiveRecord::Base
    self.table_name = :parrot_comments # FIXME: Not needed if I can isolate the gem

    belongs_to :commentable, :polymorphic => true
    belongs_to :author, :class_name => Parrot.author_class

    before_save :cache_author_data

    attr_accessible :commentable, :body

    validates_presence_of :commentable, :body, :author_id

    def self.siblings_of(other_comment)
      where(
        commentable_type: other_comment.commentable_type,
        commentable_id: other_comment.commentable_id
      )
    end

    # Bring follow up comments (may repeat +other_comment+'s  author)
    def self.following(other_comment)
      siblings_of(other_comment).where("id > #{other_comment.id}")
    end

    def author
      Parrot.author_class.find_by_id author_id
    end

    # An author may delete it's account, we cache/store it's sensitive data
    def cache_author_data
      return if author.nil?
      [:name, :email, :phone].each do |method|
        self.send(:"author_#{method}=", author.send(method)) if author.respond_to?(method)
      end
    end
  end
end
