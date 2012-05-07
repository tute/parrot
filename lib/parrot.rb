require 'parrot/version'

module Parrot
  mattr_accessor :author_class
  def self.author_class
    @@author_class.constantize
  end

  class Engine < Rails::Engine
    engine_name 'parrot'
    # isolate_namespace Parrot # FIXME: tries application url helpers (undefined method `post_comments_path')

    initializer 'parrot' do |app|
      ActiveSupport.on_load(:active_record) do
        require File.join(File.dirname(__FILE__), 'parrot', 'model_additions')
        ::ActiveRecord::Base.send :include, Parrot::Model
      end
    end
  end
end
