module Parrot
  class CommentsController < ApplicationController
    respond_to :html

    def index
      @comments = Comment.where(commentable_type: commentable_type, commentable_id: commentable_id)
      respond_with @comments
    end

    def new
      @comment = Comment.new
      respond_with @comment
    end

    def create
      @comment = Comment.new(params[:parrot_comment])
      @comment.commentable_type = commentable_type
      @comment.commentable_id = commentable_id
      @comment.author_id = current_user.id
      @commentable_type = commentable_type
      if @comment.save
        flash[:notice] = t('flash.actions.create.notice', resource_name: t('activerecord.models.comment'))
        redirect_to url_for(after_comment_path(commentable, @comment)) + '#comment_sent'
      else
        flash[:notice] = t('flash.actions.create.alert', resource_name: t('activerecord.models.comment'))
        redirect_to :back
      end
    end

    def destroy
      @comment = current_user.comments.find params[:id]
      @comment.destroy
      params[:commentable_type] = @comment.commentable_type # Set commentable_type param (maybe namespaced for example)
      respond_with @comment, :location => after_comment_path(commentable, @comment)
    end


    private

    # Following methods should belong to ApplicationController
    def commentable_fk
      commentable_fk = params.select{|k,v| k =~ /_id/ }.keys.last
    end

    def commentable_type
      if params[:commentable_type].present?
        params[:commentable_type]
      else
        commentable_fk.gsub('_id', '').camelize
      end
    end

    def commentable_id
      id = params[commentable_fk]
      if id.to_i.to_s == id # Numeric id?
        id.to_i
      else
        commentable(id).id # Slugged (coming as text, but we need numeric id)
      end
    end

    def commentable(id = nil)
      commentable_type.constantize.find(id || commentable_id)
    end

    def after_comment_path(commentable, comment)
      commentable.respond_to?(:after_comment_path) ? commentable.after_comment_path(comment) : commentable
    end

    def debug(object)
      logger.warn "DEBUGGING: #{object.inspect}"
    end
  end
end
