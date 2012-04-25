module Parrot
  module Model
    extend ActiveSupport::Concern

    module ClassMethods
      def parrot_comments
        has_many :parrot_comments, :as => :comments
      end
    end
  end
end
