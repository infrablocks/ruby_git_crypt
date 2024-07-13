# frozen_string_literal: true

require 'immutable-struct'

module RubyGitCrypt
  module Options
    class Name < ImmutableStruct.new(:name, :prefix)
      attr_reader :name

      def initialize(name)
        super(name: name.to_s)
      end

      alias to_s name

      def as_singular_key
        snake_case.to_sym
      end

      def as_plural_key
        :"#{snake_case}s"
      end

      private

      def without_prefix
        @name.sub(/^-+/, '')
      end

      def snake_case
        without_prefix.gsub('-', '_')
      end
    end
  end
end
