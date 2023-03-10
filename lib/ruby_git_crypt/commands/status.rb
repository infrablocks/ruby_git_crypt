# frozen_string_literal: true

require_relative 'base'

module RubyGitCrypt
  module Commands
    class Status < Base
      # @!visibility private
      def subcommands
        %w[status]
      end

      # @!visibility private
      def options
        super +
          %w[
            -e
            -u
            --fix
          ]
      end

      # @!visibility private
      def arguments(parameters)
        [parameters[:files]]
      end
    end
  end
end
