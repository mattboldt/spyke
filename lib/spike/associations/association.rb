require 'spike/relation'
require 'spike/result'

module Spike
  module Associations
    class Association < Relation

      attr_reader :owner

      def initialize(name, owner, options = {})
        @name, @owner,  @options = name, owner, options
      end

      private

        def foreign_key
          @options[:foreign_key] || "#{owner.class.model_name.param_key}_id"
        end

        def klass
          (@options[:class_name] || @name.to_s).classify.constantize
        end

        def fetch(path)
          fetch_embedded || super
        end

        def fetch_embedded
          Result.new(data: embedded_result) if embedded_result
        end

        def embedded_result
          owner.attributes[@name]
        end

    end
  end
end