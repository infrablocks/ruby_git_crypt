# frozen_string_literal: true

module RubyGitCrypt
  module Options
    DEFINITIONS = [
      # flag options
      definition(name: '-e', option_type: :flag, value_type: :boolean,
                 override_keys: { singular: :encrypted_only }),
      definition(name: '-u', option_type: :flag, value_type: :boolean,
                 override_keys: { singular: :unencrypted_only }),
      %w[
        --all
        --fix
        --force
        --no-commit
        --trusted
      ].map do |o|
        definition(name: o, option_type: :flag, value_type: :boolean)
      end,

      # string options
      %w[
        --key-name
      ].map do |o|
        definition(name: o, option_type: :standard, value_type: :string)
      end
    ].flatten.freeze
  end
end
