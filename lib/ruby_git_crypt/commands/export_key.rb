# frozen_string_literal: true

require_relative 'base'

module RubyGitCrypt
  module Commands
    class ExportKey < Base
      # @!visibility private
      def subcommands
        %w[export-key]
      end

      # @!visibility private
      def options
        super +
          %w[
            --key-name
          ]
      end

      # @!visibility private
      def arguments(parameters)
        [parameters[:filename]]
      end
    end
  end
end
