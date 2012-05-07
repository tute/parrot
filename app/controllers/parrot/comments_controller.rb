module Parrot
  class CommentsController < ApplicationController
    respond_to :html

    def index
      @comments = Comment.where(commentable_type: commentable_type.classify, commentable_id: commentable_id)
      respond_with @comments
    end

    def new
      @comment = Comment.new
      respond_with @comment
    end

    def create
      @comment = Comment.new(params[:parrot_comment])
      @comment.commentable_type = commentable_type.classify
      @comment.commentable_id = commentable_id
      @comment.author_id = current_user.id
      @comment.save
      @commentable_type = commentable_type
      respond_with @comment, :location => commentable
    end

    def destroy
      @comment = current_user.comments.find params[:id]
      @comment.destroy
      respond_with @comment, :location => commentable
    end

    # Following methods should belong to ApplicationController
    def commentable_fk
      commentable_fk = params.select{|k,v| k =~ /_id/ }.keys.first
    end

    def commentable_type
      commentable_fk.gsub('_id', '')
    end

    def commentable_id
      id = params[commentable_fk]
      if id.to_i.to_s == id # Numeric id
        id.to_i
      else
        commentable(id).id # Slugged (text, but we store integers)
      end
    end

    def commentable(id = nil)
      commentable_type.classify.constantize.find(id || commentable_id)
    end

    def debug(object)
      logger.warn "DEBUGGING: #{object.inspect}"
    end
  end
end
