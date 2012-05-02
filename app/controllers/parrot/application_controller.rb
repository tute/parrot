module Parrot
  class ApplicationController < ActionController::Base
    # Reading default_url_options from parent app ApplicationController
    def default_url_options(options = {})
      app_controller = ::ApplicationController.new
      app_controller.default_url_options if app_controller.respond_to? :default_url_options
    end
  end
end
