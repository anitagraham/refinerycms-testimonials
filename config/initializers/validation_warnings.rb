
module Warnings
  module Validations
    extend ActiveSupport::Concern
    include ActiveSupport::Callbacks

    included do
      define_callbacks :warning
    end

    module ClassMethods
      def warning(*args, &block)
        options = args.extract_options!
        if options.key?(:on)
          options = options.dup
          options[:if] = Array.wrap(options[:if])
          options[:if] << "validation_context == :#{options[:on]}"
        end
        args << options
        set_callback(:warning, *args, &block)
      end
    end

    # Similar to ActiveModel::Validations#valid? but for warnings
    def sensible?
      warnings.clear
      run_callbacks :warning
      warnings.empty?
    end

    # Similar to ActiveModel::Validations#errors but returns a warnings collection
    def warnings
      @warnings ||= ActiveModel::Errors.new(self)
    end
  end
end

ActiveRecord::Base.send(:include, Warnings::Validations)
