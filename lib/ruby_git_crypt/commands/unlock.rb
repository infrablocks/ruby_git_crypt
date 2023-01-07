# frozen_string_literal: true

require_relative 'base'

module RubyGitCrypt
  module Commands
    class Unlock < Base
      # @!visibility private
      def subcommands
        %w[unlock]
      end

      # @!visibility private
      def arguments(parameters)
        [parameters[:key_files]]
      end
    end
  end
end
