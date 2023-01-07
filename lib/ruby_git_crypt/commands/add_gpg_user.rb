# frozen_string_literal: true

require_relative 'base'

module RubyGitCrypt
  module Commands
    class AddGPGUser < Base
      # @!visibility private
      def subcommands
        %w[add-gpg-user]
      end

      # @!visibility private
      def options
        super +
          %w[
            --key-name
            --no-commit
            --trusted
          ]
      end

      # @!visibility private
      def arguments(parameters)
        [parameters[:gpg_user_id]]
      end
    end
  end
end
