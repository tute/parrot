module Parrot
  module Generators
    class ParrotGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      def model_exists?
        File.exists?(File.join(destination_root, model_path))
      end

      def model_path
        @model_path ||= File.join("app", "models", "#{file_path}.rb")
      end

      def inject_parrot_content
        inject_into_class(model_path, class_name, "  parrot_comments\n\n") if model_exists?
      end
    end
  end
end