# frozen_string_literal: true

require_relative 'base'

module RubyGitCrypt
  module Commands
    class Status < Base
      # @!visibility private
      def subcommands
        %w[status]
      end
    end
  end
end
