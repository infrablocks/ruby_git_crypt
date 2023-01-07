# frozen_string_literal: true

require_relative 'base'

module RubyGitCrypt
  module Commands
    class Init < Base
      # @!visibility private
      def subcommands
        %w[init]
      end

      # @!visibility private
      def options
        super +
          %w[
            --key-name
          ]
      end
    end
  end
end
