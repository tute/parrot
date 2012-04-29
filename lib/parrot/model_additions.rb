module Parrot
  module Model
    extend ActiveSupport::Concern

    module ClassMethods
      def parrot_comments
        has_many :comments, :class_name => Parrot::Comment, :as => :commentable
      end
    end
  end
end
