# frozen_string_literal: true

require_relative 'base'

module RubyGitCrypt
  module Commands
    class Lock < Base
      # @!visibility private
      def subcommands
        %w[lock]
      end

      # @!visibility private
      def options
        super +
          %w[
            --all
            --force
            --key-name
          ]
      end
    end
  end
end
