# frozen_string_literal: true

# Filtering concern which can apply to models
module Filterable
  extend ActiveSupport::Concern
  included do
    @filter_scopes ||= []
  end

  # filter methods
  module ClassMethods
    # Call the class methods with names based on the keys in <tt>filtering_params</tt>
    # with their associated values. For example, "{ status: 'delayed' }" would call
    # `filter_by_status('delayed')`. Most useful for calling named scopes from
    # URL params. Make sure you don't pass stuff directly from the web without
    # whitelisting only the params you care about first!
    attr_reader :filter_scopes

    def filter_scope(name, *args)
      scope name, *args
      @filter_scopes << name
    end

    def filter_by(params)
      results = all
      params.each do |filter_scope, filter_value|
        filter_value = filter_value.reject(&:blank?) if filter_value.is_a?(Array)
        results = results.public_send(filter_scope, filter_value) unless filter_value.blank?
      end
      results
    end
  end
end
