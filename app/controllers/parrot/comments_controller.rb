module Parrot
  class CommentsController < ActionController::Base
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

    private
      def commentable_fk
        commentable_fk = params.select{|k,v| k =~ /_id/ }.keys.first
      end
      def commentable_type
        commentable_fk.gsub('_id', '')
      end
      def commentable_id
        params[commentable_fk]
      end
      def commentable
        commentable_type.capitalize.constantize.find(commentable_id)
      end

      def debug(object)
        logger.warn "DEBUGGING: #{object.inspect}"
      end
  end
end
