module Parrot
  class ApplicationController < ActionController::Base
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
