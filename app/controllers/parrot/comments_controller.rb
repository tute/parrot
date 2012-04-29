module Parrot
  class CommentsController < ApplicationController
    respond_to :html

    def index
      @comments = Comment.where(commentable_type: commentable_type.capitalize, commentable_id: commentable_id)
      respond_with @comments
    end

    def new
      @comment = Comment.new
      @comment.commentable_type = @commentable_type = commentable_type
      @comment.commentable_id = commentable_id
      respond_with @comment
    end

    def create
      @comment = Comment.new(params[:parrot_comment])
      @comment.commentable_type = commentable_type.capitalize
      @comment.commentable_id = commentable_id
      @comment.author_id = current_user.id
      @comment.save
      @commentable_type = commentable_type
      respond_with @comment, :location => commentable
    end
  end
end
